class Monde {
  constructor(bus, id) {
    this.bus = bus
    this.id = id
    if(typeof id === 'undefined')
      this.id = uuid.v4();
    else
      this.id = id
    this.régions = [];
  }

  charge(){
    this.bus.requête(this, {
      url: '/mondes',
      method: 'GET',
      data: { id: this.id },
      dataType: 'json',
      event: 'mondeRécupéré'
    })
  }

  crée(){
    if(typeof this.id === 'undefined')
      this.id = uuid.v4();
    this.bus.requête(this, {
      url: '/mondes',
      method: 'POST',
      data: { id: this.id, taille: 'petit' },
      dataType: 'json',
      event: 'mondeCréé'
    })
  }

  static écouteLesEvènements(bus){
    bus.écoute('mondeCréé', function(évènement, paramètres){
      paramètres.origine.charge()
    })
    bus.écoute('mondeRécupéré', function(évènement, paramètres){
      paramètres.origine.régions = paramètres.réponse.régions
      bus.déclenche('mondePrêt', paramètres.origine)
    })
  }
}
