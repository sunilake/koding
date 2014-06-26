#!/usr/bin/env coffee

argv = {} ; argv[i.substring(1)] = process.argv[k+1] for i,k in process.argv when i.substring(0,1) is "-"

{exec}   = require 'child_process'
fs       = require 'fs'
log      = console.log

options =
  config      : argv.c or 'kodingme'
  hostname    : argv.h or 'koding.local'
  region      : argv.r or 'kodingme'
  branch      : argv.b or 'cake-rewrite'
  projectRoot : argv.p or '/opt/koding'
  version     : argv.v or "1.0"
  environment : argv.e or "prod"
  target      : argv.t or "rackspace"

log "BUILDING WITH ",options

configure = (o)->

  prepareHost = (callback)->

    privateKey = 
      """
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpAIBAAKCAQEAxJUfKx05K3kymTkgISnFOoh1PY/jJ3dlUnAUE8WqCXlDQi+C
        FIJO+pKGNNyo8z2fF43iCGfc9h3a0qvhvyWY4f6tkllSBdWLWwV2O8edRJXIwMyu
        ku8SIXeNg0Qg0+iqZKUZJEnv6MSUcDNejFS0AVz4Dw3pSfLT+xTEWD4j9hM6I8BQ
        qEYM2wqkyqjjIVS0bGQE0buohLiWymI4J95B5MbKuofo5eAUxkFOA+vTt66RSbWB
        BAFVg0jIDMJ4bXU28JBO8GXt0N7GkpLRPd1IEjoJ8d0iKghT6KMtwzEWyr2k6Qta
        3FybcFbjhKJneitK+ln5BXiU917p3cYAG3xRDwIDAQABAoIBACyBKiZDnm7GKHth
        4HFBmKIwxIIkciO8Nxcbwp/bTyyH5H82bDeibKjzxShwkFtJJxxZBcQrZ23cwm6R
        dTEmHN+FHdyVFim196+qo+LSxTsCwglMDXW8ZBlpjIMcSGZRNUpFylRZ3NOQtZ5V
        MuGIR5xLZOlbl+Yi8HTWdcEYiGGsAPemKTaalSAK91ak1kkb0wDpUJU/NK01glSk
        HqqsUAzmGmd19VLJhRRKNVpGbI+zhJbgl7rn0CynTdJDDtuwYwQZYjxtHDp3/UiW
        lLkBToe74L7WrNH6ZZgCCFDFx9nUAnbHPEvh6vnN5s+Ce46F69pKWihvBEyH23UT
        8wzl3IECgYEA7AnHjlK0buZLJr1IQ5YD8vd7LIK7wwHeaPOh+dhZrvn3twfibSRu
        55ew/2wmd/E5yyzgdDBGQCjPKwfs/2FnPg01KlMObAkGn0KG8j0/NecQdlv9PJgv
        lriLY7rm5O40aKMevdQ3PinvkS+KTUdbd6GfVyC77zh9HnIhW2xllc8CgYEA1TUg
        pzKQSwn8fxyKctKFf+4QEogdUPIWLgJCF8kgJGaSAl1r/wwEbQIhF8SeTEL199Cm
        5uk8w6oGlsNbPgZkF8PBuwFS3x2cbIbC+/HdWZmiPmx96o/pEZ9sWKQyX46nN9es
        5HqxULgB0m/9AxzAtFZTwV5pBWkXdIwBQuyroMECgYEAwB7JpeddY7Lg0nxYeGJ/
        fmC/iiAy8evwet5rJbBadxiQ7xJk009HUgvfDleaDCB1WRGC9C9iztAop67A0bEX
        VqNrdbK612aVVEXTDxKZA6e6d4wyWALLIVO+aQN08juMvuqemAZGnLuHelYGrRX6
        tioARuum7HS/KmvdCMv293MCgYEAhS8x3aAFaQqs8w52IfIGOPsSiTED9yuy1TzN
        4qPd8z8rmFSZgPIV1a6N05YcOJFfq1Vo3Tf3oFaW1Rjl52IApqO/Yj0acovByj2I
        ke/tkOoa4pnNMniBZGPNP7YaTX0EUirlMri+CSlY4gbY61fLvRtsKI/8VMfoQgKv
        Swoi0EECgYAHjz0jBVfpGLkkYAcaYOMcV4yFxkax4ZiuBMK4TcsrL6/KiietjmdK
        mxiIASXhNP0ZEEdAHgBr6o3EQHnJksXo7VTTBRcXOSmE7httIRrOC06qAB0kV4Ub
        qoNO+NWbDkfJB/YtKtRdUtW6QmmdUHowT10TZH24Ig7CdrdrV46X3A==
        -----END RSA PRIVATE KEY-----
      """
    
    publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDElR8rHTkreTKZOSAhKcU6iHU9j+Mnd2VScBQTxaoJeUNCL4IUgk76koY03KjzPZ8XjeIIZ9z2HdrSq+G/JZjh/q2SWVIF1YtbBXY7x51ElcjAzK6S7xIhd42DRCDT6KpkpRkkSe/oxJRwM16MVLQBXPgPDelJ8tP7FMRYPiP2EzojwFCoRgzbCqTKqOMhVLRsZATRu6iEuJbKYjgn3kHkxsq6h+jl4BTGQU4D69O3rpFJtYEEAVWDSMgMwnhtdTbwkE7wZe3Q3saSktE93UgSOgnx3SIqCFPooy3DMRbKvaTpC1rcXJtwVuOEomd6K0r6WfkFeJT3XundxgAbfFEP ubuntu@kodingme"

    known_hosts = 
      """
      |1|KJ2CvsrRClkfR52SKkmi6wJGks8=|AKgtdjkpxcLBoZ5PPC/eIukHYs0= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGvN9gZ2BtULXGo3fMaZJgbbNbsED7KEirN+KwPso82ydiO9jeVDQ/feNR5xH6/lqiuDZCA7mZek/njpWxeAYBk=
      |1|lXvT04jC94yCSNAkFiYqkNyx9o8=|cT9C1yYSCWkDqY/601HucfBjMOw= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGvN9gZ2BtULXGo3fMaZJgbbNbsED7KEirN+KwPso82ydiO9jeVDQ/feNR5xH6/lqiuDZCA7mZek/njpWxeAYBk=
      """
    ssh_config =
      """
      Host github.com
        StrictHostKeyChecking no
      Host git.sj.koding.com
        StrictHostKeyChecking no
      """
    iptableRules =
      """
      #!/bin/sh -e
      iptables -F
      iptables -A INPUT -i lo -j ACCEPT
      iptables -A INPUT -s 208.72.139.54 -j ACCEPT
      iptables -A INPUT -s 70.197.5.50 -j ACCEPT
      iptables -A INPUT -s 208.87.56.148 -j ACCEPT
      iptables -A INPUT -s 208.87.59.205 -j ACCEPT
      iptables -A INPUT -s 94.54.193.66 -j ACCEPT
      iptables -A INPUT -s 78.184.209.65 -j ACCEPT
      iptables -A INPUT -s 68.68.97.155 -j ACCEPT
      iptables -A INPUT -s 85.107.151.5 -j ACCEPT
      iptables -A INPUT -p tcp --dport 4000 -j ACCEPT
      iptables -A INPUT -p tcp --dport 3999 -j ACCEPT
      iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
      iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
      iptables -A INPUT -j DROP      
      """
    
    try
      fs.mkdirSync     "/root/.ssh"
    fs.writeFileSync "/root/.ssh/id_rsa"     ,privateKey
    fs.writeFileSync "/root/.ssh/id_rsa.pub" ,publicKey
    fs.writeFileSync "/root/.ssh/config"     ,ssh_config
    fs.writeFileSync "/etc/rc.local"         ,iptableRules
    fs.chmodSync     "/root/.ssh/id_rsa"     ,0o0600

    fs.mkdirSync     "/root/BUILD_DATA"
    fs.writeFileSync "/root/BUILD_DATA/BUILD_HOSTNAME"      ,o.hostname
    fs.writeFileSync "/root/BUILD_DATA/BUILD_REGION"        ,o.region
    fs.writeFileSync "/root/BUILD_DATA/BUILD_CONFIG"        ,o.config
    fs.writeFileSync "/root/BUILD_DATA/BUILD_BRANCH"        ,o.branch
    fs.writeFileSync "/root/BUILD_DATA/BUILD_ENVIRONMENT"   ,o.environment
    fs.writeFileSync "/root/BUILD_DATA/BUILD_PROJECT_ROOT"  ,o.projectRoot
    fs.writeFileSync "/root/BUILD_DATA/BUILD_VERSION"       ,o.version
    fs.writeFileSync "/etc/hostname"                        ,o.hostname
    
    exec "/etc/rc.local && hostname #{o.hostname}",()->
      log "iptableRules flushed, hostname is set.",arguments
      callback null


  createDataForDockerBuild = (callback)->
    exec """
    mkdir -p ./install/BUILD_DATA
    echo #{o.hostname}     >./install/BUILD_DATA/BUILD_HOSTNAME
    echo #{o.region}       >./install/BUILD_DATA/BUILD_REGION
    echo #{o.config}       >./install/BUILD_DATA/BUILD_CONFIG
    echo #{o.branch}       >./install/BUILD_DATA/BUILD_BRANCH
    echo #{o.projectRoot}  >./install/BUILD_DATA/BUILD_PROJECT_ROOT
    echo #{o.environment}  >./install/BUILD_DATA/BUILD_ENVIRONMENT
    echo #{o.version}      >./install/BUILD_DATA/BUILD_VERSION
    """,->
      log "build data is written for docker deploy."
      callback null

  checkDocker = (callback) ->
    exec "docker version",(err,stdout)->
      if stdout.indexOf("Client version:") > -1
        console.log "docker cmd found. all good."
        callback null
      else
        console.log "Please install Docker first. Exiting."
        process.exit()

  fetchDockerAuthFile = (callback) ->
    fs.readFile (process.env['HOME']+"/.dockercfg"),(err,res)->
      if err then callback "-" else callback res+""

  prepareConfigFile = (callback) ->
    configFile = require "./config/main.#{o.config}.coffee"
    configJSON = JSON.stringify(configFile,null,4)
    fs.writeFile "./install/BUILD_DATA/BUILD_CONFIG.json",configJSON,(err,res)->
      if err
        console.log "couldn't write config file. exiting."
        process.exit()
      else
        console.log "BUILD_CONFIG.json written."
        callback null             


  authToDocker = (callback) ->
    dockerAuth = '{"https://index.docker.io/v1/":{"auth":"ZGV2cmltOm45czQvV2UuTWRqZWNq","email":"devrim@koding.com"}}'
    authToken = "ZGV2cmltOm45czQvV2UuTWRqZWNq"
    fetchDockerAuthFile (file)->
      if file.indexOf(authToken) is -1
        fs.writeFile "#{process.env['HOME']}/.dockercfg",dockerAuth,(err)->
          console.log "docker file written."
          callback null
      else
        console.log "docker file correct. unchanged."
        callback null

  if o.target is not 'localhost'
    prepareHost()

  authToDocker (err)->
    if o.target is 'localhost'
      createDataForDockerBuild ->
        prepareConfigFile ->
          log "configure complate for #{o.target}."
    else if o.target is 'rackspace'
      prepareHost ->
        console.log "configure complete #{o.target}."





configure options

