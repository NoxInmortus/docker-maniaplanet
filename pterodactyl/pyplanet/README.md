# Maniaplanet + PyPlanet Pterodactyl egg

1. Import egg into Pterodactyl
2. Add 2 port allocations to node
3. Create server with those allocations
4. Set database limit to 1
5. Fill in the variables
6. Replace TM_SERVER_PORT with the primary allocated port and SERVER_P2P_PORT with the secondary
7. Start install (takes a hot minute)
8. Create a new database (make sure Pterodactyl databases are properly set up)
9. Go to whatever database manager you use and convert the new database from `uftmb4_general_ci` to `uftmb4_unicode_ci`
10. Configure PyPlanet, database host should be `pterodactyl0` interface IP (usually 172.18.0.1)
11. Finished! You can of course configure it further with extra apps and configurations, but you have a basic PyPlanet server! Congratulations!

You could probably remove lots of the dependencies from the Dockerfile, but I won't bother with that now.
I could make a better stop command, but Pterodactyl sends the stop command to the running server (in this case ManiaPlanetServer) not to a shell so you can't use a stop.sh script. I'm not 100% sure if PyPlanet stops gracefully with my method. 

If you have sensable suggestions on how to improve this, make an issue or PR and I'll probably add them.
