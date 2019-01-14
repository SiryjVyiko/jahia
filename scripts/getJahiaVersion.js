//@auth

var baseUrl = "${baseUrl}";

var storage = use("scripts/useStorageApi.js");

var userData = storage.getUserData();
var ftpUser = userData.credentials.ftpUser;
return storage.getVersion(ftpUser, ${settings.envName}, ${settings.backupDir});

function use(script) {
    var Transport = com.hivext.api.core.utils.Transport,
        body = new Transport().get(baseUrl + "/" + script + "?_r=" + Math.random());
    var debug = baseUrl + "/" + script + "?_r=" + Math.random();

    return new (new Function("return " + body)())(session);
}
