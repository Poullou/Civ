class Bus {

  constructor(){
    this.configuration = {
      baseApi: '/api/v1'
    }
  }

  requête(origine, paramètres){
    var that = this
    $.ajax({
      url: this.configuration['baseApi'] + paramètres['url'],
      method: paramètres['method'],
      data: paramètres['data'],
      dataType: 'json',
      success: function(réponse){
        that.déclenche(paramètres['event'], { origine: origine, réponse: réponse })
      },
      error: function(){
        that.déclenche('erreur')
      }
    })
  }

  déclenche(évènement, paramètres){
    $(window).trigger(évènement, paramètres)
  }

  écoute(évènement, callback){
    $(window).on(évènement, callback)
  }
}
