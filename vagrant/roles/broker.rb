name "broker"
description "The  role for Broker servers"

run_list ["recipe[nodejs]","recipe[golang]","recipe[supervisord]"]

default_attributes({
                     "kd_deploy" => {
                                "git_branch" => "master_autoscale",
                                "revision_tag" => "HEAD",
                                "release_action" => :deploy,
                                "deploy_dir" => '/opt/koding',
                     },
                     "launch" => {
                                "config" => "autoscale",
                                "programs" => ["goBroker"]
                     }
})
