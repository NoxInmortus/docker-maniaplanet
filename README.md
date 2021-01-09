# Docker-Trackmania

This work is based on PyPlanet docker image (https://github.com/PyPlanet/maniaplanet-docker).

My goal is to be up-to-date and to be much more customisable.

- Use latest alpine image
- Use latest Maniaplanet server
- Lighter image
- Multi architectures (see below)
- Cleaner and more readable Dockerfile and entrypoint
- Every `dedicated_cfg` option is customisable through environment variable

Works great with https://git.tools01.imperium-gaming.fr/sysadmins/docker/docker-trackmania

Version 1.0

## Official NoxInmortus repositories

Find more at :
- https://git.tools01.imperium-gaming.fr/public
- https://github.com/NoxInmortus?tab=repositories

## Available Architectures
- amd64
- arm64 (aarch64)
- armv7 (arm)

## Common Usage
```
docker run --name=trackmania -d -v trackmania:/home/container --restart=unless-stopped \
  -p 2350:2350 -p 2350:2350/udp -p 3450:3450 -p 3450:3450/udp
  -e MASTERSERVER_ACCOUNT='MyAccountName' \
  -e MASTERSERVER_ACCOUNT_PWD='P@55w0rd' \
  -e MASTERSERVER_KEY='yOuRkEy' \
  -e SUPERADMIN_PWD='AnotherP@55w0rd' \
  -e ADMIN_PWD='AnotherP@55w0rd' \
  -e SERVER_NAME='Aw3s0meS3rV3r' \
  -e MAX_PLAYERS='16' \
  -e MAX_SPECTATORS='6' \
  -e SERVER_PASSWORD='s0m371ng'
 noxinmortus/docker-trackmania
```

Once started, you can also manually edit the `config.xml` as it will not be overwritten if the file exist. Same thing for the `matchsettings.xml`

## Configuration

Volume to mount is `/home/container` (Pterodactyl compliant) and contains all Trackmania files.

|Ports|Usage|
|-|-|
|2350|Server TCP port|
|2350/udp|Server UDP port|
|3450|Server P2P TCP port|
|3450/udp|Server P2P UDP port|
|5000|XMLRPC Port|

|Environment variables|Default|Usage|
|-|-|-|
|MASTERSERVER_ACCOUNT|None||
|MASTERSERVER_ACCOUNT_PWD|None||
|MASTERSERVER_KEY|None|Validation key||
|FORCE_IP_ADDRESS|`$(wget -4 -qO- http://ifconfig.co)`||
|SERVER_PORT|`2350`||
|SERVER_P2P_PORT|`3450`||
|XMLRPC_PORT|`5000`||
|XMLRPC_ALLOW_REMOTE|`True`|If you specify an ip adress here, it'll be the only accepted adress. this will improve security|
|TITLE|`TMStadium@nadeo`|SMStorm, TMCanyon...|
|TITLE_PACK_URL|`https://v4.live.maniaplanet.com/ingame/public/titles/download/TMStadium@nadeo.Title.Pack.gbx`||
|TITLE_PACK_FILE|None||
|DEDICATED_CFG|`config.xml`||
|MATCH_SETTINGS|`MatchSettings/matchsettings.xml`||
|SUPERADMIN_NAME|`SuperAdmin`||
|SUPERADMIN_PWD|`SuperAdmin`||
|ADMIN_NAME|`Admin`||
|ADMIN_PWD|`Admin`||
|SERVER_NAME|`My Trackmania Server`||
|COMMENT|None||
|HIDE_SERVER|`0`|value is 0 (always shown), 1 (always hidden), 2 (hidden from nations)|
|MAX_PLAYERS|`32`||
|SERVER_PASSWORD|None||
|MAX_SPECTATORS|`32`||
|PASSWORD_SPECTATOR|None||
|KEEP_PLAYER_SLOTS|`False`|when a player changes to spectator, should the server keep if player slots/scores etc.. or not|
|LADDER_MODE|`forced`|value between 'inactive', 'forced' (or '0', '1')|
|P2P_UPLOAD|`True`||
|P2P_DOWNLOAD|`False`||
|CALLVOTE_TIMEOUT|`60000`||
|CALLVOTE_RATIO|`0.5`|default ratio. value in [0..1], or -1 to forbid|
|ALLOW_MAP_DOWNLOAD|`True`||
|AUTOSAVE_REPLAYS|`False`||
|AUTOSAVE_VALIDATION_REPLAYS|`False`||
|REFEREE_PASSWORD|None||
|REFEREE_VALIDATION_MODE|`0`|value is 0 (only validate top3 players),  1 (validate all players)|
|USE_CHANGING_VALIDATION_SEED|`False`||
|DISABLE_HORNS|`False`||
|MAX_LATENCY|`0`|0 mean automatic adjustement|
|LADDER_SERVERLIMIT_MIN|None||
|LADDER_SERVERLIMIT_MAX|None||
|CONN_UPLOAD_RATE|`8000`|Kbits per second|
|CONN_DOWNLOAD_RATE|`8000`|Kbits per second|
|ALLOW_SPECTATOR_RELAYS|`False`||
|P2P_CACHE_SIZE|`600`||
|CLIENT_PORT|None||
|BIND_IP_ADDRESS|None||
|USE_NAT_UPNP|None||
|GSP_NAME|None|Game Server Provider|
|GSP_URL|None|If you're a server hoster, you can use this to advertise your services|
|SCRIPTCLOUD_SOURCE|`nadeocloud`|Specify the cloud storage mode for Titles that use it. Can be "localdebug" or "xmlrpc" or "nadeocloud" (default). "nadeocloud" will work only if the creator of the title subscribed to the cloud service|
|BLACKLIST_URL|None||
|GUESTLIST_FILENAME|None||
|BLACKLIST_FILENAME|None||
|MIN_CLIENT_BUILD|None|Only accept updated client to a specific version. ex: 2011-10-06|
|DISABLE_COHERENCE_CHECKS|`False`|disable internal checks to detect issues/cheats, and reject race times|
|DISABLE_REPLAY_RECORDING|`False`|disable replay recording in memory during the game to lower memory usage|
|SAVE_ALL_INDIVIDUAL_RUNS|`False`|Save all the ghosts from the match replay to individual ghost.gbx files, in folder {servername}/Autosaves/Runs_{mapname}/|
|USE_PROXY|`False`||
|PROXY_LOGIN|None||
|PROXY_PWD|None||

## Sources
- https://github.com/PyPlanet/maniaplanet-docker
- http://blog.zot24.com/tips-tricks-with-alpine-docker/
- https://doc.maniaplanet.com/dedicated-server/getting-started
- https://pterodactyl.io/community/config/eggs/creating_a_custom_image.html#creating-the-dockerfile
