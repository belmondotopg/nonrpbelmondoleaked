// console.log("Starting xrs-queue JS script");
const { Client, Intents } = require('discord.js');
const axios = require('axios');
const fs = require('fs').promises;

const client = new Client({
    intents: [
        Intents.FLAGS.GUILDS,
        Intents.FLAGS.GUILD_MEMBERS,
        Intents.FLAGS.GUILD_MESSAGES,
        Intents.FLAGS.MESSAGE_CONTENT,
    ]
});
// console.log("Client initialized");

exports("getWhitelist", async (discord) => {
    try {
        // console.log("getWhitelist function called");
        const guild = guilds.cache.get(a_queue.serverID);
        let member = await guild.members.fetch(discord)
        if (member) {
            // console.log("Member found");
            for (let index = 0; index < member._roles.length; index++) {
                const role = member._roles[index];
                if (role === a_queue.whitelistRole) {
                    // console.log("Whitelist role found");
                    return true
                }
            }
            return false
        } else {
            // console.log("Member not found");
            return false
        }
    } catch (error) {
        // console.log("getWhitelist function error:", error);
        return false
    }
});

exports("getPremiumRanks", async (discordid) => {
    try {
        // console.log("getPremiumRanks function called");
        const guild = guilds.cache.get(a_queue.serverID);
        let member = await guild.members.fetch(discordid)
        if (member) {
            // console.log("Member found");
            let ranks = []
            for (let index = 0; index < member._roles.length; index++) {
                const role = member._roles[index];
                if (a_queue.ranks[role]) {
                    ranks.push(role);
                }
            }
            if (ranks.length == 0) {
                ranks = null
            }
            return ranks
        } else {
            // console.log("Member not found");
            return null
        }
    } catch (error) {
        // console.log("getPremiumRanks function error:", error);
        return false
    }

});

async function updateBotActivity() {
    try {
        // console.log("updateBotActivity function called");
        const [maxSlots, playersResponse] = await Promise.all([
            GetConvarInt('sv_maxclients', 200),
            axios.get('http://83.168.105.24:30125/players.json')
        ]);

        const playerCount = playersResponse.data.length;

        let activityMessage = `${playerCount}/${maxSlots} ~ nonrp.eu`;

        client.user.setActivity(activityMessage, { type: 'PLAYING' });
    } catch (error) {
        console.error('Błąd z pobieraniem danych:', error);
    }
}

client.on('ready', () => {
    // console.log(`Logged in as ${client.user.tag}!`);
    updateBotActivity();
    setInterval(updateBotActivity, 60000);
});

client.on("error", error => {
    // console.log("xrs-queue JS ERROR: ",error)
});

client.on('shardError', error => {
	console.error('JS A websocket connection encountered an error:', error);
});

client.login(a_queue.botToken);
