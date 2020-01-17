$(document).ready(function(){
    $(".three-circles").click(function(){
        var id = $(this).attr("id")
        $(".kite#" + id + ", .action-links#" + id).fadeToggle()
    })

    var hidden_inputs = $("input[type=hidden]");
    $.each(hidden_inputs, function(i, input){
        var name = $(this).attr("name")
        if(name == "project_user[write_access]" || name == "project_user[read_access]" || name == "project_user[update_access]" || name == "project_user[delete_access]"){
            var fields = $("input[name='" + name + "']")
            
            $.each(fields, function(i, field){
                if ($(field).attr("type") == "hidden"){
                    $(field).remove()
                }else{
                    $(field).removeAttr("value")
                }
            })
        }else{
            // console.log("nah")
        }
    })
})
Rails.ajax({
    url: "/books",
    type: "get",
    data: "",
    success: function(data) {
        console.log("Hey there working");
    },
    error: function(data) {
        console.log("Ooops... Sorry not workin");
    }
  })
  