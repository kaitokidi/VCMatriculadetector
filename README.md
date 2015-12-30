# VCMatriculadetector
Genís Bayona, Gonzalo Diez
Quadrimestre 1 2015/2016

## Treball realitzat
Per aquesta pràctica, hem construït un Lector de matrícules.
Aquest treball s'ha fet en el context de l'assignatura de VC (Visió per Computadors) de la FIB (Facultat Informàtica de Barcelona), de la UPC (Universitat Politècnica de Catalunya).
Cursem aquesta assignatura el quadrimestre d'hivern de 2015.
En aquesta pràctica proposada per Manel Farigola, Antoni Grau i Joan Aranda s'han tractat els diferents temes estudiats a la teoria de l'assignatura, per tal de veure'ls i aplicar-los en un entorn pràctic, i veure'n la utilitat en una aplicació usable i de fet usada en el món real.
En el treball podem destacar diferents subtasques que hem anat solucionant per acabar tenint el lector de matrícules complert. A continuació les explicarem detalladament:


## Detecció i localització de la matrícula:
En aquest apartat hem rebut una imatge en la qual hi havia un cotxe, amb la seva matrícula, i hem aplicat diferents processos per tal de acabar obtenint la posició de la matrícula.
Per tractar aquest problema, la nostre solució passa la imatge a blanc i negre per poder treballar-hi més còmodament. Vam probar de fer la binarització en fraccions de la imatge, però no ens va donar resultats positius, així que vam decidir seguir amb la binarització que es dona a partir d’un threshold obtingut a partir de la funció de matlab graythresh. Després de aplicar alguns filtres per netejar la imatge i obtenir-ne diferents regions en blanc i negre (utilitzant funcions de matlab imclearborder, histeq, im2bw, imopen ... ), utilitzant els regionprops vam anar filtrant casos, fins a quedar-nos només amb alguns dels candidats sel·leccionats com a matrícula. Tots els candidats els vam guardar en un array per no perdre'ls, i així si un candidat no ens dona una matrícula poder buscar al següent.
##### Detectar candidats a caràcters de la matrícula:
En aquest pas, donada una finestra de la imatge com a matrícula, hem designat els candidats a ser caràcters de la matrícula.
Amb la finestra de matrícula obtinguda en l'apartat anterior, no ens ha calgut si no utilitzar el bwlabel i diferents condicions dels regionprops per poder filtrar els candidats a caràcters de la matrícula. Es podrien haver aplicat coses més complexes i elaborades, però aquesta solució ens donava molt bons resultats, així que vam decidir avançar més en la detecció de matrícules en sí i en la identificació dels caràcters per acabar de fer el filtre i que només aquells que realment són caràcters apareguin com a tals.
##### Determinar característiques del caràcter:
Donat un caràcter obtingut amb en el pas anterior, buscar-ne les característiques que després utilitzarem per la classificació.
Les diferents característiques utilitzades, després de ajustaments i probes, de canvis i de adaptació de paràmetres, hem utilitzat els elements de regionprops perímetre i àrea, nombre de Euler i els resultats de aplicar unes funcions pròpies de signatura polar i slope representation, en les quals es discretitzen els valors de les funcions, i es normalitzen per tenir així característiques independents de la mida i poder tractar amb cert marge de rotacions dels caràcters classificats i per classificar.
Funció de classificació dels caràcters segons les característiques extretes:
En aquest pas aplicarem els resultats dels passos anteriors per alimentar la funció de classificació que ens donarà amb certes probabilitats el caràcter que el nostre sistema prediu que hi ha en la finestra obtinguda.
Per fer la classificació hem utilitzat el treebagger que ens an ensenyar a les classes de la assignatura. Primer vam entendre com funcionava, vam veure que funcionava bé amb els exemples de training, i després vam ajustar els paràmetres per tal que la performance/time ens dongués un resultat acceptable. Per valors baixos el classificador anava molt ràpid, però els resultats no eren bons, en canvi quan vam anar augmentant, cada vegada el temps era més alt, però ens donaven resultats més bons. Prop dels 200 vam veure un pic de millora per temps, i a partir d'aquí, per bé que segui a classificant bé, ja ens anava augmentant massa el temps de execució com perquè valgués la pena pujar més, així que ens vam quedar amb els 200.
##### Ampliació dels exemples de training:
Per tal de poder entrenar millor el nostre classificador, partint de pocs elements de training (els proporcionats a la pràctica), vam crear unes funcions que ens generaven nous exemples a partir dels que ja teníem. Per fer això, vam utilitzar petites deformacions de les lletres combinades amb diferents rotacions, per poder tractar matrícules que no es veiessin de forma totalment frontal, i vam fer exemples amb soroll per aquelles imatges en les que la resolució o la distorsió de la imatge causaven canvis en les lletres que no s'haurien reconegut fàcilment amb els elements de training habituals.
##### Finalització del programa:
Una vegada tenim totes les peces, ajuntar-les en un sistema de lectura de matrícules i presentació de resultats.
No va resultar difícil, ja que vam anar implementant les diferents funcions de forma ben estructurada i modular, i vigilant que funcionés pas a pas, així que gràcies a la bona planificació i a una implementació correcte, no hi ha hagut especials complicacions en aquest aspecte.
Per tal de tenir més bona resposta de cara l'usuari, vam fer que els candidats de matrícula quedessin ressaltades, i també els candidats a caràcter dins d'aquestes. A més, el predictor ens ensenya sobre la imatge original les lletres de la matrícula sobre on ha detectat que hi pot haver un caràcter, amb el signe ~ si no n'està molt segur.


## Característiques utilitzades
Inicialment, vam utilitzar Característiques extretes del ''regionprops'', i combinacions d'aquestes (com perímetre/àrea o aquests valors al quadrat) però els resultats eren bastant pobres, així que vam tirar per altres tècniques. Vam estar provant diferents implementacions de Slope representation i signatura polar. Inicialment no funcionaven molt bé, especialment la funció de slope, però després de la normalització dels resultats i de la adaptació de diferents paràmetres que havíem incorporat per discretitzar les funcions, vam trobar uns resultats que ens donaven unes prediccions bastant acurades i amb una ràtio d'encert bastant bona, i ens els vam quedar.




## Resultats

Estem molt contents amb els resultats finals del treball, ja que hem aconseguit detectar gairebé totes les matrícules, i les prediccions del classificador són bastant encertades. És cert que no és un producte comercialitzable, i que es podria millorar en diferents aspectes, però hem après molt sobre com funciona la visió per computador, hem aplicat a la pràctica conceptes que des de la explicació teòrica no semblaven tant interessants o importants o útils, i ens hem obert una porta a seguir experimentant i seguir aprenent en aquest interessantíssim camp, que té moltes aplicacions que ja s'utilitzen avui en dia, però també moltes que encara estan per trobar, descobrir, inventar i explotar.

En qualsevol cas, creiem que com a experiència personal i acadèmica els objectius d'aquest treball han estat àmpliament assolits, i els resultats suficientment bons. Al iniciar el treball ens va semblar que difícilment assoliríem el nivell de encert que hem acabat tenint, i per bé que hi ha hagut alguns casos que ens han superat i que no hem aconseguit resoldre, la gran majoria els hem resolt bé, i n'estem orgullosos. A més, també entenem que en un primer projecte en aquest camp, i en l'entorn de la universitat en el qual hem tingut moltes altres ocupacions de altres camps i àrees, tampoc ens hem pogut dedicar tant com hauríem volgut al projecte, i que en un altre ambient, els resultats haurien estat encara més bons.

A la carpeta Soluciones es poden veure els resultats obtinguts en les imatges de prova que teníem i alguna complementària que hem afegit nosaltres.

Amb la versió  Matlab2011a, tenint el mateix codi, podem veure que els resultats són més bons que amb la versió en la que vam fer la demostració als laboratoris de la FIB (Matlab2012b). Creiem que és per una implementació diferent del treebagger.
