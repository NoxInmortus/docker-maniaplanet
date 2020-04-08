#!/bin/sh

# Make sure we use defaults everywhere.
: ${TITLE:="TMStadium@nadeo"}
: ${TITLE_PACK_URL:="https://v4.live.maniaplanet.com/ingame/public/titles/download/TMStadium@nadeo.Title.Pack.gbx"}
: ${DEDICATED_CFG:="config.xml"}
: ${MATCH_SETTINGS:="MatchSettings/matchsettings.xml"}
: ${SERVER_NAME:="My Trackmania Server"}
: ${SERVER_PORT:="2350"}

# We are required to get the public ip if we don't have it in our env currently.
if [ -z ${FORCE_IP_ADDRESS+x} ]; then
   FORCE_IP_ADDRESS=`wget -4 -qO- http://ifconfig.co`
fi
echo "=> Going to run on forced IP: ${FORCE_IP_ADDRESS} and port: ${SERVER_PORT}"

# Copy the configuration files if not yet copied.
mkdir -pv ${PROJECT_DIR}/UserData/Config ${PROJECT_DIR}/UserData/Packs ${PROJECT_DIR}/UserData/Maps/MatchSettings
## {{{ config.xml
if [ ! -f ${PROJECT_DIR}/UserData/Config/config.xml ]; then
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<dedicated>
	<authorization_levels>
		<level>
			<name>${SUPERADMIN_NAME:-SuperAdmin}</name>
			<password>${SUPERADMIN_PWD:-SuperAdmin}</password>
		</level>
		<level>
			<name>${ADMIN_NAME:-Admin}</name>
			<password>${ADMIN_PWD:-Admin}</password>
		</level>
	</authorization_levels>

 	<masterserver_account>
		<login>${MASTERSERVER_ACCOUNT:-}</login>
		<password>${MASTERSERVER_ACCOUNT_PWD:-}</password>
		<validation_key>${MASTERSERVER_KEY:-}</validation_key>
	</masterserver_account>

	<server_options>
		<name>${SERVER_NAME:-}</name>
		<comment>
			${COMMENT:-}
		</comment>
		<hide_server>${HIDE_SERVER:-0}</hide_server>
		<max_players>${MAX_PLAYERS:-32}</max_players>
		<password>${SERVER_PASSWORD:-}</password>
		<max_spectators>${MAX_SPECTATORS:-32}</max_spectators>
		<password_spectator>${PASSWORD_SPECTATOR:-}</password_spectator>
		<keep_player_slots>${KEEP_PLAYER_SLOTS:-False}</keep_player_slots>
		<ladder_mode>${LADDER_MODE:-forced}</ladder_mode>
		<enable_p2p_upload>${P2P_UPLOAD:-True}</enable_p2p_upload>
		<enable_p2p_download>${P2P_DOWNLOAD:-False}</enable_p2p_download>
		<callvote_timeout>${CALLVOTE_TIMEOUT:-60000}</callvote_timeout>
		<callvote_ratio>${CALLVOTE_RATIO:-0.5}</callvote_ratio>
		<callvote_ratios>
			<voteratio command=\"Ban\" ratio="-1"/>
			<!-- commands can be \"Ban\", \"Kick\", \"RestartMap\", \"NextMap\", \"SetModeScriptSettingsAndCommands\"... -->
		</callvote_ratios>
		<allow_map_download>${ALLOW_MAP_DOWNLOAD:-True}</allow_map_download>
		<autosave_replays>${AUTOSAVE_REPLAYS:-False}</autosave_replays>
		<autosave_validation_replays>${AUTOSAVE_VALIDATION_REPLAYS:-False}</autosave_validation_replays>
		<referee_password>${REFEREE_PASSWORD:-}</referee_password>
		<referee_validation_mode>${REFEREE_VALIDATION_MODE:-0}</referee_validation_mode>
		<use_changing_validation_seed>${USE_CHANGING_VALIDATION_SEED:-False}</use_changing_validation_seed>
		<disable_horns>${DISABLE_HORNS:-False}</disable_horns>
		<clientinputs_maxlatency>${MAX_LATENCY:-0}</clientinputs_maxlatency>
		<ladder_serverlimit_min>${LADDER_SERVERLIMIT_MIN:-}</ladder_serverlimit_min>
		<ladder_serverlimit_max>${LADDER_SERVERLIMIT_MAX:-}</ladder_serverlimit_max>
	</server_options>

	<system_config>
		<connection_uploadrate>${CONN_UPLOAD_RATE:-8000}</connection_uploadrate>
		<connection_downloadrate>${CONN_DOWNLOAD_RATE:-8000}</connection_downloadrate>
		<allow_spectator_relays>${ALLOW_SPECTATOR_RELAYS:-False}</allow_spectator_relays>
		<p2p_cache_size>${P2P_CACHE_SIZE:-600}</p2p_cache_size>
		<force_ip_address>${FORCE_IP_ADDRESS:-}</force_ip_address>
		<server_port>${SERVER_PORT:-2350}</server_port>
		<server_p2p_port>${SERVER_P2P_PORT:-3450}</server_p2p_port>
		<client_port>${CLIENT_PORT:-0}</client_port>
		<bind_ip_address>${BIND_IP_ADDRESS:-}</bind_ip_address>
		<use_nat_upnp>${USE_NAT_UPNP:-}</use_nat_upnp>
		<gsp_name>${GSP_NAME:-}</gsp_name>
		<gsp_url>${GSP_URL:-}</gsp_url>
		<xmlrpc_port>${XMLRPC_PORT:-5000}</xmlrpc_port>
		<xmlrpc_allowremote>${XMLRPC_ALLOW_REMOTE:-True}</xmlrpc_allowremote>
		<scriptcloud_source>${SCRIPTCLOUD_SOURCE:-nadeocloud}</scriptcloud_source>
		<blacklist_url>${BLACKLIST_URL:-}</blacklist_url>
		<guestlist_filename>${GUESTLIST_FILENAME:-}</guestlist_filename>
		<blacklist_filename>${BLACKLIST_FILENAME:-}</blacklist_filename>
		<title>${TITLE:-TMStadium@nadeo}</title>
		<minimum_client_build>${MIN_CLIENT_BUILD:-}</minimum_client_build>
		<disable_coherence_checks>${DISABLE_COHERENCE_CHECKS:-False}</disable_coherence_checks>
		<disable_replay_recording>${DISABLE_REPLAY_RECORDING:-False}</disable_replay_recording>
		<save_all_individual_runs>${SAVE_ALL_INDIVIDUAL_RUNS:-False}</save_all_individual_runs>
		<use_proxy>${USE_PROXY:-False}</use_proxy>
		<proxy_login>${PROXY_LOGIN:-}</proxy_login>
		<proxy_password>${PROXY_PWD:-}</proxy_password>
	</system_config>
</dedicated>
" > ${PROJECT_DIR}/UserData/Config/config.xml
fi
## config.xml }}}
if [ ! -f ${PROJECT_DIR}/UserData/Maps/MatchSettings/matchsettings.xml ]; then
    cp -v ${TEMPLATE_DIR}/matchsettings.xml ${PROJECT_DIR}/UserData/Maps/MatchSettings/matchsettings.xml
fi
if [ ! -f ${PROJECT_DIR}/UserData/Maps/stadium_map.Map.gbx ]; then
    cp -v ${TEMPLATE_DIR}/stadium_map.Map.gbx ${PROJECT_DIR}/UserData/Maps/stadium_map.Map.gbx
fi

# Download title.
if [ -z ${TITLE_PACK_FILE+x} ]; then
  echo "=> Downloading newest title version with no TITLE_PACK_FILE variable"
  wget ${TITLE_PACK_URL} -qP ./UserData/Packs/
else
  echo "=> Downloading newest title version to ${TITLE_PACK_FILE}"
  wget ${TITLE_PACK_URL} -qO ./UserData/Packs/${TITLE_PACK_FILE}
fi

if [ -z ${MASTERSERVER_ACCOUNT+x} ]; then
  echo 'MASTERSERVER_ACCOUNT variable should not be empty if it is not a LAN-only server !'
fi

# Set trap to stop the script proprely when a docker stop is executed
trap : EXIT TERM KILL INT SIGKILL SIGTERM SIGQUIT

# Start dedicated.
echo "=> Starting server, login=${MASTERSERVER_ACCOUNT:-} with additional parameters : ${@:-None}"
./ManiaPlanetServer ${@} \
    /nodaemon \
    /forceip=${FORCE_IP_ADDRESS}:${SERVER_PORT} \
    /dedicated_cfg=${DEDICATED_CFG} \
    /game_settings=${MATCH_SETTINGS}
