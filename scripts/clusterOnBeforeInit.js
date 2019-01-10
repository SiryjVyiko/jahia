//@auth

function prepareTags(values) {
    var aResultValues = [];

    values = values || [];

    for (var i = 0, n = values.length; i < n; i++) {
        aResultValues.push({ caption: values[i], value: values[i] });
    }

    return aResultValues;
}

var tags = jelastic.env.control.GetDockerTags(appid, session, "jahiadev/processing");
var tagsList = prepareTags(tags.object);

jelastic.local.returnResult({
    result: 0,
    settings: {
        fields: [{
            "caption": "Jahia version",
            "type": "list",
            "name": "tag",
            "required": true,
            "default": (tagList[0] || {}).value || "",
            "values": tagList
        }]
    }
});
