class ExamenMedical {
  final int id;
  final int consultationId;
  final double? poids;
  final double? taille;
  final double? imc;
  final double? tension;
  final double? visionD;
  final double? visionG;
  final int? larmoiement;
  final int? douleurs;
  final int? tachesYeux;
  final int? auditionD;
  final int? auditionG;
  final int? sifflements;
  final int? angines;
  final int? epistaxis;
  final int? rhinorrhee;
  final int? cephalies;
  final int? vertiges;
  final int? troublesSommeil;
  final int? peauNormal;
  final int? peauAnormale;
  final int? douleursMusculaires;
  final int? douleursArticulaires;
  final int? douleursNeurologiques;
  final int? toux;
  final int? dyspnee;
  final int? douleursThoraciques;
  final int? palpitations;
  final int? oedemes;
  final int? cyanose;
  final int? pyrosis;
  final int? vomissements;
  final int? douleursAbdominales;
  final int? dysurie;
  final int? hematurie;
  final int? cyclesIrreguliers;
  final String? fonctionRespiratoire;
  final String? fonctionCirculatoire;
  final String? fonctionMotrice;
  final String? sanguins;
  final String? urinaires;
  final String? radiologiques;
  final int? hepatitesPos;
  final int? hepatitesNeg;
  final int? syphilisPos;
  final int? syphilisNeg;
  final int? vihPos;
  final int? vihNeg;

  ExamenMedical({
    required this.id,
    required this.consultationId,
    this.poids,
    this.taille,
    this.imc,
    this.tension,
    this.visionD,
    this.visionG,
    this.larmoiement,
    this.douleurs,
    this.tachesYeux,
    this.auditionD,
    this.auditionG,
    this.sifflements,
    this.angines,
    this.epistaxis,
    this.rhinorrhee,
    this.cephalies,
    this.vertiges,
    this.troublesSommeil,
    this.peauNormal,
    this.peauAnormale,
    this.douleursMusculaires,
    this.douleursArticulaires,
    this.douleursNeurologiques,
    this.toux,
    this.dyspnee,
    this.douleursThoraciques,
    this.palpitations,
    this.oedemes,
    this.cyanose,
    this.pyrosis,
    this.vomissements,
    this.douleursAbdominales,
    this.dysurie,
    this.hematurie,
    this.cyclesIrreguliers,
    this.fonctionRespiratoire,
    this.fonctionCirculatoire,
    this.fonctionMotrice,
    this.sanguins,
    this.urinaires,
    this.radiologiques,
    this.hepatitesPos,
    this.hepatitesNeg,
    this.syphilisPos,
    this.syphilisNeg,
    this.vihPos,
    this.vihNeg,
  });

  factory ExamenMedical.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic v) =>
        v == null ? null : double.tryParse(v.toString());
    int? parseInt(dynamic v) => v == null ? null : int.tryParse(v.toString());

    return ExamenMedical(
      id: parseInt(json['id']) ?? 0,
      consultationId: parseInt(json['consultation_id']) ?? 0,
      poids: parseDouble(json['poids']),
      taille: parseDouble(json['taille']),
      imc: parseDouble(json['IMC']),
      tension: parseDouble(json['tension']),
      visionD: parseDouble(json['vision_d']),
      visionG: parseDouble(json['vision_g']),
      larmoiement: parseInt(json['larmoiement']),
      douleurs: parseInt(json['douleurs']),
      tachesYeux: parseInt(json['taches_yeux']),
      auditionD: parseInt(json['audition_d']),
      auditionG: parseInt(json['audition_g']),
      sifflements: parseInt(json['sifflements']),
      angines: parseInt(json['angines']),
      epistaxis: parseInt(json['epistaxis']),
      rhinorrhee: parseInt(json['rhinorrhee']),
      cephalies: parseInt(json['cephalies']),
      vertiges: parseInt(json['vertiges']),
      troublesSommeil: parseInt(json['troubles_sommeil']),
      peauNormal: parseInt(json['peau_normal']),
      peauAnormale: parseInt(json['peau_anormale']),
      douleursMusculaires: parseInt(json['douleurs_musculaires']),
      douleursArticulaires: parseInt(json['douleurs_articulaires']),
      douleursNeurologiques: parseInt(json['douleurs_neurologiques']),
      toux: parseInt(json['toux']),
      dyspnee: parseInt(json['dyspnee']),
      douleursThoraciques: parseInt(json['douleurs_thoraciques']),
      palpitations: parseInt(json['palpitations']),
      oedemes: parseInt(json['oedemes']),
      cyanose: parseInt(json['cyanose']),
      pyrosis: parseInt(json['pyrosis']),
      vomissements: parseInt(json['vomissements']),
      douleursAbdominales: parseInt(json['douleurs_abdominales']),
      dysurie: parseInt(json['dysurie']),
      hematurie: parseInt(json['hematurie']),
      cyclesIrreguliers: parseInt(json['cycles_irreguliers']),
      fonctionRespiratoire: json['fonction_respiratoire'],
      fonctionCirculatoire: json['fonction_circulatoire'],
      fonctionMotrice: json['fonction_motrice'],
      sanguins: json['sanguins'],
      urinaires: json['urinaires'],
      radiologiques: json['radiologiques'],
      hepatitesPos: parseInt(json['hepatites_pos']),
      hepatitesNeg: parseInt(json['hepatites_neg']),
      syphilisPos: parseInt(json['syphilis_pos']),
      syphilisNeg: parseInt(json['syphilis_neg']),
      vihPos: parseInt(json['vih_pos']),
      vihNeg: parseInt(json['vih_neg']),
    );
  }
}
