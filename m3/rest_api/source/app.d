import vibe.vibe;
import virus_total;
import db_conn;

import std.stdio;

void main()
{

    auto dbClient = DBConnection("root", "example", "mongo", "27017", "testing");
    auto virusTotalAPI = new VirusTotalAPI(dbClient);

    auto router = new URLRouter;
    router.registerRestInterface(virusTotalAPI);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["0.0.0.0"];
    auto listener = listenHTTP(settings, router);
    
    router.get("/" , &home);
    // router.post("/signup" , &register);
    

    scope (exit)
    {
        listener.stopListening();
    }

    writeln(router.getAllRoutes());
    runApplication();
}

void home(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("landing.dt")(res);
    // res.writeBody("Salut!");
}

struct registerUser {
    string userEmail;
    string username;
    string password;
    string name;
    string desc;
}

// void register(HTTPServerRequest req, HTTPServerResponse res) {
//     auto data = req.body.readAll().deserializeJSON;
//     writeln(data);
// }