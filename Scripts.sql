/*Window functions = functions that calculate a value for each row using a “window” of related rows, without collapsing rows like GROUP BY.

Basic syntax
<function>() OVER (PARTITION BY ... ORDER BY ... [frame])

PARTITION BY: splits data into groups (like group-by, but rows stay).
ORDER BY: orders rows inside each group (needed for ranking/running totals).
Frame (optional): which rows around the current row are included (e.g., last 7 rows)

Basic syntax
<function>() OVER (PARTITION BY ... ORDER BY ... [frame])

 */


-- Common uses (examples)
# Ranking
SELECT *, ROW_NUMBER() OVER (PARTITION BY C_MKTSEGMENT ORDER BY C_ACCTBAL DESC) AS rn
FROM MY_DATABASE.PUBLIC.CUSTOMER_S21;

# Running total
SELECT C_NATIONKEY, C_ACCTBAL,
       SUM(C_ACCTBAL) OVER (PARTITION BY C_NATIONKEY ORDER BY C_CUSTKEY
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sum
FROM MY_DATABASE.PUBLIC.CUSTOMER_S21;


# Previous/next row (LAG/LEAD)

SELECT C_NATIONKEY, C_CUSTKEY, C_ACCTBAL,
       LAG(C_ACCTBAL) OVER (PARTITION BY C_NATIONKEY ORDER BY C_CUSTKEY) AS prev_bal
FROM MY_DATABASE.PUBLIC.CUSTOMER_S21;



 --connect to a remote server
ssh user@hostname 

ssh -p 2222 user@hostname --connect on a specific port

ssh -i ~/.ssh/key.pem user@hostname — --connect using a private key

-- This forwards your local port 8080 to port 80 on the remote server.
ssh -L 8080:localhost:80 user@server


/* Flag	Purpose
-p	Specify port
-i	Specify identity/key file
-L	Local port forwarding
-R	Remote port forwarding
-v	Verbose mode (for debugging)
-N	No remote command (used with tunnels)

Common operations:

ssh-keygen — generate a new SSH key pair
ssh-copy-id user@hostname — copy your public key to a server for passwordless login
ssh user@hostname 'command' — run a command on the remote server without opening a shell
*/

--SCP = Secure Copy — it copies files between your computer and a remote server over SSH.

1. Upload (local → remote)

scp file.txt john@192.168.1.10:/home/john/

file.txt — the file on your computer
john — your username on the remote server
192.168.1.10 — the remote server's IP address
/home/john/ — where to put the file on the remote server


2. Download (remote → local)

scp john@192.168.1.10:/home/john/report.txt ./

john@192.168.1.10:/home/john/report.txt — the file on the remote server
./ — save it in your current folder locally
Think of it like: "bring that file HERE"

3. Copy a whole folder (-r)

scp -r my_folder/ john@192.168.1.10:/home/john/

-r means recursive — copies the folder and everything inside it
Without -r, SCP only copies single files





--git config --global user.name "Your Name"
--git config --global user.email "your-email@example.com"

git remote add origin https://github.com/Muhhammad9999/Fathima
git branch -M main
git push -u origin main

git config --global user.name "Shafi Mohammed"

git config --global user.name
git config --global user.email

git add .
git commit -m "ok"
git push -u origin main

/* 
Ansible is an open-source IT automation tool used for:

Configuration management — set up and maintain servers consistently
Application deployment — deploy apps across many servers at once
Orchestration — coordinate multi-step processes across systems
Provisioning — spin up cloud infrastructure


# Key features:
Feature	Description
Agentless	No software needed on remote machines — uses SSH
Playbooks	Tasks written in simple YAML files
Idempotent	Running it multiple times produces the same result
Inventory	Define groups of servers to manage
Modules	3000+ built-in modules for common tasks

How it works:
You write a playbook (YAML) describing the desired state
Ansible connects to remote machines via SSH
Executes tasks and reports results
No agent installation required on target machines
It's widely used in DevOps for managing infrastructure at scale.
ansible all -m ping                       # test connectivity
ansible-playbook deploy.yml               # run a playbook
ansible all -a "uptime"                   # run a command on all hosts
*/