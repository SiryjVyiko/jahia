//@auth

var baseUrl = "https://raw.githubusercontent.com/SiryjVyiko/jahia/master";

var storage = use("scripts/useStorageApi.js");

var userData = storage.getUserData();
var ftpUser = userData.credentials.ftpUser;
return storage.getVersion(ftpUser, "env-6034", "2019-01-10T13:52:52-manual");

function use(script) {
    var Transport = com.hivext.api.core.utils.Transport,
        body = new Transport().get(baseUrl + "/" + script + "?_r=" + Math.random());
    var debug = baseUrl + "/" + script + "?_r=" + Math.random();

    return new (new Function("return " + body)())(session);
}
