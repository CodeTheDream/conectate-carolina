FactoryBot.define do
  factory :message do
    title { "Severe Thunderstorm expected this weekends!" }
    body { "SEVERE THUNDERSTORM WATCH 330 IS IN EFFECT UNTIL 1000 PM EDT FOR THE FOLLOWING LOCATIONS NC ..." }
    posted { true }
    message_type { "warning" }
    titulo { "Se esperan fuertes tormentas este fin de semana!" }
    cuerpo { "SEVERE THUNDERSTORM WATCH 330 ESTÁ EN EFECTO HASTA LAS 1000 PM EDT PARA LAS SIGUIENTES UBICACIONES NC ..." }
  end
end
