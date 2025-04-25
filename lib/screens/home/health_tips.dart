class HealthTips {
  static final List<String> tips = [
    'Pratiquez des techniques de relaxation comme la respiration profonde pour réduire votre stress.',
    'Buvez au moins 8 verres d\'eau par jour pour rester bien hydraté.',
    'Faites une pause de 20 secondes toutes les 20 minutes lorsque vous travaillez sur écran.',
    'Une marche de 30 minutes par jour peut améliorer significativement votre santé.',
    'Prenez le temps de bien mâcher vos aliments pour une meilleure digestion.',
    'Privilégiez les escaliers à l\'ascenseur pour plus d\'activité physique.',
    'Mangez un arc-en-ciel de fruits et légumes pour varier vos nutriments.',
    'Dormez 7-8 heures par nuit pour maintenir une bonne santé mentale.',
    'Étirez-vous doucement au réveil pour activer votre circulation.',
    'Méditez 10 minutes par jour pour réduire l\'anxiété.',
    'Prenez une pause déjeuner loin de votre bureau pour déconnecter.',
    'Gardez une bonne posture lorsque vous êtes assis.',
    'Riez souvent, c\'est un excellent exercice pour le corps et l\'esprit.',
    'Évitez les écrans une heure avant le coucher pour mieux dormir.',
    'Pratiquez la gratitude en notant 3 choses positives chaque jour.',
    'Alternez position assise et debout si vous travaillez sur ordinateur.',
    'Écoutez de la musique relaxante pour réduire le stress.',
    'Mangez des fruits secs comme collation plutôt que des sucreries.',
    'Faites des exercices de respiration pendant vos pauses.',
    'Restez socialement actif, c\'est bon pour le moral et la santé.',
  ];

  static String getRandomTip() {
    tips.shuffle();
    return tips.first;
  }
}
