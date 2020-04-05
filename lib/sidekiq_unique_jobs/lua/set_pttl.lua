-------- BEGIN keys ---------
local digest    = KEYS[1]
local queued    = KEYS[2]
local primed    = KEYS[3]
local locked    = KEYS[4]
local info      = KEYS[5]
local changelog = KEYS[6]
local digests   = KEYS[7]
-------- END keys ---------


-------- BEGIN lock arguments ---------
local job_id       = ARGV[1]
local pttl         = tonumber(ARGV[2])
local lock_type    = ARGV[3]
local limit        = tonumber(ARGV[4])
-------- END lock arguments -----------


--------  BEGIN injected arguments --------
local current_time = tonumber(ARGV[5])
local debug_lua    = ARGV[6] == "true"
local max_history  = tonumber(ARGV[7])
local script_name  = tostring(ARGV[8]) .. ".lua"
local redisversion = ARGV[9]
---------  END injected arguments ---------


--------  BEGIN local functions --------
<%= include_partial "shared/_common.lua" %>
----------  END local functions ----------


---------  BEGIN set_pttl.lua ---------
log_debug("BEGIN set pttl:", digest, "job_id:", job_id)

if pttl and pttl > 0 then
  log_debug("PEXPIRE", digest, pttl)
  redis.call("PEXPIRE", digest, pttl)

  log_debug("PEXPIRE", queued, pttl)
  redis.call("PEXPIRE", queued, pttl)

  log_debug("PEXPIRE", primed, pttl)
  redis.call("PEXPIRE", primed, pttl)

  log_debug("PEXPIRE", locked, pttl)
  redis.call("PEXPIRE", locked, pttl)

  log_debug("PEXPIRE", info, pttl)
  redis.call("PEXPIRE", info, pttl)
end
