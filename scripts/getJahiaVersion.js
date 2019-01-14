//@auth

var baseUrl = "https://raw.githubusercontent.com/SiryjVyiko/jahia/master";

var storage = use("scripts/useStorageApi.js");

var userData = storage.getUserData();
var ftpUser = userData.credentials.ftpUser;
var version = storage.getVersion(ftpUser, "env-6034", "2019-01-10T13:52:52-manual");
if (version.result != 0) {
    version = { result: 0, version: "7.2.1.1" } //for compatibility with old backups where Jahia version is not saved
}

return version;

function use(script) {
    var Transport = com.hivext.api.core.utils.Transport,
        body = new Transport().get(baseUrl + "/" + script + "?_r=" + Math.random());
    var debug = baseUrl + "/" + script + "?_r=" + Math.random();

    return new(new Function("return " + body)())(session);
}
