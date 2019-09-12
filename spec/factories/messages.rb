FactoryBot.define do
  factory :message do
    title { "Severe Storms Threats!" }
    body { "Threats of severe storms and heavy rain that could cause flash flooding can be expected Tuesday from the southern High Plains to the Upper Midwest. The primary threats from severe weather are damaging winds and large hail. Severe weather threats shift into the Middle Mississippi Valley and Mid-Atlantic on Wednesday. And then we are done" }
    posted { true }
    message_type { "warning" }
    titulo { "Amenazas de tormentas severas!" }
    cuerpo { "Las amenazas de fuertes tormentas y fuertes lluvias que podrían causar inundaciones repentinas pueden esperarse el martes desde las planicies del sur hasta el medio oeste superior. Las principales amenazas del clima severo son los vientos dañinos y el granizo grande. Las amenazas de clima severo cambian el miércoles al valle medio de Mississippi y al Atlántico medio." }
    posted_at { Time.zone.now }
  end
end
