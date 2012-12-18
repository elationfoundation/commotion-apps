m = Map("applications", translate("Commotion applications"), translate("Applications used in the Commotion bundle."))

d = m:section(TypedSection, "application", translate("Application"))

d:option(Value, "name", "name"); d.optional=false; d.rmempty = false;
d:option(Value, "nick", "nick"); d.optional=false; d.rmempty = false; 
d:option(Value, "ipaddr", "ipaddr"); d.optional=false; d.rmempty = false; 
d:option(Value, "port", "port"); d.optional=false; d.rmempty = false;
d:option(Value, "icon", "icon"); d.optional=false; d.rmempty = false;
d:option(Value, "description", "desc"); d.optional=false; d.rmempty = false;
d:option(ListValue, "type", "type"); d.default = misc; d.optional = true; 
return m
