
-- filtre Lua qui lit la métadonnée author du YAML
-- puis crée un nouvelle métadonnée author-bibtex

function Meta(meta)
  -- On récupère les auteurs
  local authors = meta.author
  if not authors then
    return meta
  end

  local names = {}

  for _, a in ipairs(authors) do
    if a.t == "MetaMap" and a.name then
      table.insert(names, pandoc.utils.stringify(a.name))
    else
      table.insert(names, pandoc.utils.stringify(a))
    end
  end
  -- Création d'une nouvelle métadonnée au format BibTeX
  meta["author-bibtex"] = pandoc.MetaString(table.concat(names, " and\n "))
  return meta
end