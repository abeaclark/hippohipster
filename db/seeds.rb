
tags_and_identifiers = {
      punk: ['punk'],
      rap: ['rap'],
      hiphop: ['hip', 'hop'],
      edm: ['electronic', 'edm', 'house'],
      classical: ['classical', 'instrumental'],
      indie: ['independent', 'indie'],
      rock: ['rock'],
      jazz: ['jazz', 'smooth']
      }

tags_and_identifiers.each do |key, value|

  tag = Tag.create!({
      value: key.to_s
    })

  value.each do |identifier|
    tag.identifiers << Identifier.create!({
          value: identifier
          })
  end

end
