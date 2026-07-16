-- [nfnl] fnl/juice/filetypes.fnl
local filetypes = {extension = {avsc = "json", bb = "clojure", edn = "clojure", mill = "scala", mysql = "sql", pgsql = "sql", sbt = "scala", sc = "scala", service = "systemd", tofu = "hcl", txt = "text"}, filename = {[".envrc"] = "bash", Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}, pattern = {["openapi.*%.yaml"] = "yaml.openapi", ["openapi.*%.json"] = "json.openapi"}}
local function _1_()
  return vim.filetype.add(filetypes)
end
return {setup = _1_}
