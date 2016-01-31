class Monde {
  constructor(bus, id) {
    this.bus = bus
    if(typeof id === 'undefined')
      this.id = uuid.v4();
    else
      this.id = id
    this.régions = [];
  }

  charge(){
    this.bus.requête({
      url: '/mondes',
      method: 'GET',
      data: { id: this.id },
      dataType: 'json',
      success: 'mondeRécupéré',
      error: 'erreur'
    })
  }

  crée(){
    this.bus.requête({
      url: '/mondes',
      method: 'POST',
      data: { id: this.id, taille: 'petit' },
      dataType: 'json',
      success: 'mondeCréé',
      error: 'erreur'
    })
  }

  écouteLesEvènements(){
    var that = this
    this.bus.écoute('mondeCréé', function(){
      that.charge()
    })
    this.bus.écoute('mondeRécupéré', function(évènement, paramètres){
      that.régions = paramètres.réponse.régions
    })
  }
}
