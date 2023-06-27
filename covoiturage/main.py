import db
from flask import Flask, render_template, request, redirect, url_for, session
from passlib.context import CryptContext
password_ctx = CryptContext(schemes=['bcrypt'])

app = Flask(__name__)

app.secret_key = b'secretkey'

@app.route("/", methods = ['GET', 'POST'])
def page_connexion():
  #pour voir si l'utilisateur est toujours connecté#
  if session.get('login'):
    return redirect('/page_organisation_trajet')
  #######
  login_error = ''
  email = request.form.get('email')
  mdp = request.form.get('mdp')
  with db.connect() as conn:
    with conn.cursor() as cur:
      cur.execute("select mdp, nom from utilisateur where email = %s",(email,))
      result = cur.fetchone()
  if mdp != None:
    if password_ctx.verify(mdp, result[0]):
      session['login'] = True
      session['email'] = email
      session['nom'] = result[1]
      return redirect('/page_organisation_trajet')
    else:
      login_error = 'mauvais mot de passe'
  return render_template('page_connexion.html', login_error = login_error)

@app.route("/page_creer_compte", methods = ['GET', 'POST'])
def page_creer_compte():
  error = ''
  if request.method == 'POST':
    email = request.form.get('email')
    mdp = request.form.get('mdp')
    nom = request.form.get('nom')
    prenom = request.form.get('prenom')
    adresse = request.form.get('adresse')
    date_nai = request.form.get('date_nai')
    permis = request.form.get('permis')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select * from utilisateur where email = %s",(email,))
        result = cur.fetchone()
    if result != None:
      error = 'Adresse e-Mail déjà utilisée'
    else:
      hash_pw = password_ctx.hash(mdp)
      with db.connect() as conn:
        with conn.cursor() as cur:
          cur.execute("insert into utilisateur(email, nom, prenom, adresse, date_nai, mdp, permis) values (%s, %s, %s, %s, %s, %s, %s)",(email, nom, prenom, adresse, date_nai, hash_pw, permis))
      return redirect('/page_profil')
  return render_template('page_creer_compte.html', error = error)

@app.route("/page_profil", methods = ['GET', 'POST'])
def page_profil():
  if not session.get('login'):
    return redirect('/')
  return render_template('page_profil.html', email = session['email'])

@app.route("/page_ajout_vehicule", methods = ['GET', 'POST'])
def page_ajout_vehicule():
  if not session.get('login'):
    return redirect('/')
  error = ''
  message = ''
  if request.method == 'POST':
    immat = request.form.get('immat')
    modele = request.form.get('modele')
    places = request.form.get('places')
    couleur = request.form.get('couleur')
    carburant = request.form.get('carburant')
    classe = request.form.get('classe')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select * from vehicule where immat = %s",(immat,))
        result = cur.fetchone()
    if result != None:
      error = 'Immatriculation déjà utilisée'
    else:
      with db.connect() as conn:
        with conn.cursor() as cur:
          cur.execute("insert into vehicule(immat, modele, places, couleur, carburant, classe, email) values (%s, %s, %s, %s, %s, %s, %s)",(immat, modele, places, couleur, carburant, classe, session['email']))
          message = 'Véhicule ajouté avec succès'
  return render_template('page_ajout_vehicule.html', error = error, message = message)

@app.route("/page_gerer_vehicule", methods = ['GET', 'POST'])
def page_gerer_vehicule():
  result = []
  email = session['email']
  with db.connect() as conn:
    with conn.cursor() as cur:
      cur.execute("select * from vehicule where email = %s",(email,))
      result = cur.fetchall()
  if request.method == "POST":
    check = request.form.get('check')
    if check == "delete":
      with db.connect() as conn:
        with conn.cursor() as cur:
          cur.execute("delete from vehicule where email = %s",(email,))
      session['last_page'] = '/page_gerer_vehicule'
      return redirect('/dummy')
    else:
      session['immat'] = result[int(check)]
      return redirect('/page_modifier_info')
  return render_template('page_gerer_vehicule.html', len = len(result), liste_vehicule = result)

@app.route("/page_modifier_info")
def page_modifier_info():
  if request.method == "POST":
    immat = request.form.get('immat')
    modele = request.form.get('modele')
    places = request.form.get('places')
    couleur = request.form.get('couleur')
    carburant = request.form.get('carburant')
    classe = request.form.get('classe')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("update vehicule set immat = %s, modele = %s, places = %s, couleur = %s, carburant = %s, classe = %s where immat = %s",(immat, modele, places, couleur, carburant, classe, session['immat'],))
  return render_template('page_modifier_info.html', vehicule = session['immat'])

@app.route("/page_historique", methods = ["GET"])
def page_historique():
  with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select date_t, cout, distance, immat, adresse from trajet natural join localisation where email = %s;",(session['email'],))
        result = cur.fetchall()
  return render_template('page_historique.html', len = len(result), liste_historique = result)

@app.route("/page_operation", methods = ["GET"])
def page_operation():
  with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select * from parraine_rem where userpar = %s;",(session['email'],))
        liste_parraine = cur.fetchall()
  return render_template('page_operation.html', len = len(liste_parraine), liste_parraine = liste_parraine)

@app.route("/page_organisation_trajet")
def page_organisation_trajet():
  return render_template('page_organisation_trajet.html')

@app.route("/page_recherche_trajet", methods =["GET", "POST"])
def page_recherche_trajet():
  if request.method == "POST":
    destination = request.form.get('destination')
    date = request.form.get('date')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select idt, email, adresse, modele, date_t from trajet join localisation on trajet.lieu = localisation.idl natural join vehicule where adresse = %s and date_t = %s;",(destination, date))
        result = cur.fetchall()
    session['resultat'] = result
    return redirect('/page_resultat')
  return render_template('page_recherche_trajet.html')

@app.route("/page_resultat", methods =["GET", "POST"]) 
def page_resultat():
  result = session['resultat']
  if request.method == "POST":
    session['idt'] = request.form.get('idt')
    return redirect('/page_propose_etape')
  return render_template('page_resultat.html', len = len(result), liste_result = result)

@app.route("/page_propose_etape", methods =["GET", "POST"])
def page_propose_etape():
  idt = session['idt']
  message = ''
  if request.method == "POST":
    destination = request.form.get('destination')
    time = request.form.get('time')
    date = request.form.get('date')
    description = request.form.get('description')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select max(idl) from localisation")
        result = cur.fetchone()
    idl = result[0] + 1
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("insert into localisation(idl, nom, adresse, description) values (%s, %s, %s, %s)",(idl, 'localisation de ' + session['nom'], destination, description))
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select max(ide) from etape")
        result = cur.fetchone()
    ide = result[0] + 1
    message = 'Étape proposée avec succès'
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("insert into etape(ide, heure_p, heure_a, lieu, email, traj) values (%s, %s, %s, %s, %s, %s)",(ide, date + ' ' + time, date + ' ' + time, idl, session['email'], session['idt']))
  return render_template('page_propose_etape.html', idt = idt, message = message)

@app.route("/page_gerer_trajet", methods =["GET", "POST"])
def page_gerer_trajet():
  with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select idt, date_t, adresse from trajet join localisation on trajet.lieu = localisation.idl where email = %s",(session['email'],))
        result = cur.fetchall()
  if request.method == "POST":
    session['idt'] = request.form.get('idt')
    return redirect('/page_gerer_etape')
  return render_template('page_gerer_trajet.html', len = len(result), liste_trajet = result)

@app.route("/page_gerer_etape", methods =["GET", "POST"])
def page_gerer_etape():
  with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select ide, email, adresse, heure_p from etape join localisation on etape.lieu = localisation.idl where traj = %s;",(session['idt'],))
        result = cur.fetchall()
  if request.method == "POST":
    ide = request.form.get('ide')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("delete from etape where ide = %s",(ide,))
      session['last_page'] = '/page_gerer_etape'
      return redirect('/dummy')
  return render_template('page_gerer_etape.html', len = len(result), liste_etape = result)

@app.route("/page_publier_trajet", methods =["GET", "POST"])
def page_publier_trajet():
  with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select immat, modele from vehicule where email = %s",(session['email'],))
        liste_vehicule = cur.fetchall()
  if request.method == "POST":
    destination = request.form.get('destination')
    date = request.form.get('date')
    vehicule = request.form.get('vehicule')
    cout = request.form.get('cout')
    distance =request.form.get('distance')
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select max(idl) from localisation")
        result = cur.fetchone()
    idl = result[0] + 1
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("insert into localisation(idl, nom, adresse, description) values (%s, %s, %s, %s)",(idl, 'localisation de ' + session['nom'], destination, ''))
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("select max(idt) from trajet")
        result = cur.fetchone()
    idt = result[0] + 1
    with db.connect() as conn:
      with conn.cursor() as cur:
        cur.execute("insert into trajet(idt, date_t, cout, distance, immat, lieu, email) values (%s, %s, %s, %s, %s, %s, %s)",(idt, date, cout, distance, liste_vehicule[int(vehicule)][0], idl, session['email'],))
  return render_template('page_publier_trajet.html', len = len(liste_vehicule), liste_vehicule = liste_vehicule)

@app.route("/page_trajet_en_cours")
def page_trajet_en_cours():
  return render_template('page_trajet_en_cours.html')

@app.route("/page_statistiques")
def page_statistiques():
  return render_template('page_statistiques.html')

@app.route("/dummy")
def dummy():
  return redirect(session['last_page'])

if __name__ == '__main__':
  app.run()
