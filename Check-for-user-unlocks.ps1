#script to check who unlocked a user account.


function Send-SlackMessage {
    # Add the "Incoming WebHooks" integration to get started: https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
    param (
        [Parameter(Mandatory=$true, Position=0)]$Text,
        $Url="https://hooks.slack.com/services/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", #Put your URL here so you don't have to specify it every time.
        # Parameters below are optional and will fall back to the default setting for the webhook.
        $Username, # Username to send from.
        $Channel, # Channel to post message. Can be in the format "@username" or "#channel"
        $Emoji, # Example: ":bangbang:".
        $IconUrl # Url for an icon to use.
    )

    $body = @{ text=$Text; channel=$Channel; username=$Username; icon_emoji=$Emoji; icon_url=$IconUrl } | ConvertTo-Json
    Invoke-WebRequest -Method Post -Uri $Url -Body $body
}

 $Log = Get-EventLog -computername localhost -LogName Security -InstanceId 4767 -Newest 1 | fl -Property Message | out-string
    $FirstName1 = ($log -split "Name",4)[1]
    $FirstName2 = ($FirstName1 -split "Account",2)[0]
    $FirstFinal = $FirstName2 -replace '\s',''a
 
    $SecondName1 = ($log -split "Name",4)[2]
    $SecondName2 = ($SecondName1 -split "Account",2)[0]
    $SecondFinal = $SecondName2 -replace '\s',''

Send-SlackMessage "***$FirstFinal has unlocked $SecondFinal from $env:computername!***" -Channel "#account-lockouts"