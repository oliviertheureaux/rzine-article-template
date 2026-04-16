function Meta(meta)
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

  meta["author-bibtex"] = pandoc.MetaString(table.concat(names, " and\n "))
  return meta
end