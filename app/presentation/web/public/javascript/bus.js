class Bus {

  constructor(){
    this.configuration = {
      baseApi: '/api/v1'
    }
  }

  requête(paramètres){
    var that = this
    $.ajax({
      url: this.configuration['baseApi'] + paramètres['url'],
      method: paramètres['method'],
      data: paramètres['data'],
      dataType: paramètres['dataType'],
      success: function(réponse){
        that.déclenche(paramètres['success'], { requête: paramètres['data'], réponse: réponse })
      },
      error: function(){
        that.déclenche(paramètres['error'], paramètres['data'])
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
