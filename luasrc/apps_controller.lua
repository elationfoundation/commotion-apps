--[[

appSplash - LuCI based Application Front end.
Copyright (C) <2012>  <Seamus Tuohy>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

module("luci.controller.commotion.apps_controller", package.seeall)

require "luci.model.uci"
require "luci.http"
require "luci.sys"
function index()
    entry({"apps"}, call("load_apps"), "Local Applications", 20).dependent=false
	e.target = call("action_add")
    entry({"apps", "list"}, cbi("commotion/apps_cbi")).dependent=false
    entry({"apps", "add"}, template("commotion/apps_add")).dependent=false
	entry({"apps", "add"}).target = call("action_add")
	end


function load_apps()

local name, nick, ip, port, apps, app,  description, i, r
local uci = luci.model.uci.cursor()
local categories = {}
local apps = {}
uci:foreach("applications", "application",
   function(s)
       if s.name then
	       if  luci.sys.call("nc -z " .. s.ipaddr .. " " .. s.port) == 0 then
	       table.insert(apps,s)
   end end end)
   
for _, r in pairs(apps) do
	if r.type then
	  	 for _, t in pairs(r.type) do
		  	if categories[t] then
                appName = r.name
				categories[t][appName] = r
			else
		  	    categories[t] = {}
				appName = r.name
				categories[t][appName] = r
			end
		 end
	else appName = r.name
	 	  if categories['misc'] then
		  	 categories['misc'][appName] = r
		  else
			categories['misc'] = {}
			categories['misc'][appName] = r
		  end
	 end
end
	 luci.template.render("commotion/apps_view", {categories=categories})
end


function action_add()

local uci = luci.model.uci.cursor()
UUID = luci.sys.uniqueid(9) .. luci.http.formvalue("appName")

local values = {
	  ['name'] =  luci.http.formvalue("appName"),
	  ['ipaddr'] =  luci.http.formvalue("IP"),
	  ['icon'] =  luci.http.formvalue("source"),
	  ['nick'] =  luci.http.formvalue("appNick"),
	  ['description'] =  luci.http.formvalue("description"),
	  ['fingerprint'] = luci.http.formvalue("fingerprint"),
}

if  luci.http.formvalue("port") then
	  values['port'] =  luci.http.formvalue("port")
end

if  luci.http.formvalue("fingerprint") then
	  values['fingerprint'] =  luci.http.formvalue("fingerprint")
end


uci:section('applications', 'application', UUID, values)

for x, i in pairs(luci.http.formvalue()) do
	if x == "types" then
		uci:set_list('applications', UUID, x, i)
	end
end
uci:save('applications')
uci:commit('applications')
end
