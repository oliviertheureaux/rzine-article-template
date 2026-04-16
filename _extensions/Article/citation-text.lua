local function stringify(x)
return pandoc.utils.stringify(x)
end

local function extract_year(meta_date)
if not meta_date then
return ""
end
local s = stringify(meta_date)
-- récupère une année du type 2026 dans "2026-04-16" ou texte voisin
local y = s:match("(%d%d%d%d)")
return y or s
end

local function authors_to_text(authors)
local names = {}

for _, a in ipairs(authors) do
if a.t == "MetaMap" and a.name then
table.insert(names, stringify(a.name))
else
  table.insert(names, stringify(a))
end
end

local n = #names
  if n == 0 then
return ""
elseif n == 1 then
return names[1]
elseif n == 2 then
return names[1] .. " et " .. names[2]
else
  return table.concat(names, ", ", 1, n - 1) .. " et " .. names[n]
end
end

function Meta(meta)
local authors = meta.author or {}
local author_text = authors_to_text(authors)
local year = extract_year(meta.date)
local title = meta.title and stringify(meta.title) or ""
local journal = "Rzine"

local doi = ""
if meta.doi then
doi = " https://doi.org/" .. stringify(meta.doi)
end

local citation =
  author_text .. " (" .. year .. "). " ..
title .. ". " ..
journal .. "." ..
doi

meta["citation-text"] = pandoc.MetaString(citation)
return meta
end