post '/api/v1/mondes' do
  Commande::Monde::CréerUnMonde.new.exécute(params)
  json true
end

get '/api/v1/mondes' do
  json Requete::Monde::VoirLeMonde.new.exécute(params[:id])
end
