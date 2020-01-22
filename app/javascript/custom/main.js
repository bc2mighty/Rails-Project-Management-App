$(document).ready(function(){

    console.clear()

    $(".three-circles").click(function(){
        console.log("Hello There");        
        var id = $(this).attr("id")
        $(".kite#" + id + ", .action-links#" + id).fadeToggle()
    })

    if($("input#project_id").val() != "" && typeof $("input#project_id").val() != 'undefined'){
        // window.location.assign("http://localhost:3000/users/projects/" + $(project_id).val() + "/users");
        console.log($("input#project_id").val());
    }

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

    $("#user_project_edit_form").on("submit", function(e){
        e.preventDefault();
        var write_access = $("#write_access").is(":checked"),
        read_access = $("#read_access").is(":checked"),
        update_access = $("#update_access").is(":checked"),
        delete_access = $("#delete_access").is(":checked"),
        project_user_id = $("#project_user_id").val(),
        project_id = $("#project_id").val();  

        $.ajax({
            url: 'http://localhost:3000/api/v1/projects/user/' + project_id + '/update',
            type: 'json',
            method: 'post',
            data: {
                project_user_id: project_user_id,
                write_access: write_access,
                read_access: read_access,
                update_access: update_access,
                delete_access: delete_access
            },
            success: function(data){
                console.log(data);                
                if(data.status == "SUCCESS"){
                    window.location.assign("http://localhost:3000/users/projects/" + project_id + "/users");
                }else{
                    $("#edit_user_project_access").removeAttr("disabled");
                    $("<div class='alert alert-danger'>Please Try Again, and error occured</div>").insertAfter($(".descriptor-h3"));
                }
            },
            error: function(data){
                console.log("Error Gotten there");
            }
        })
    })
})