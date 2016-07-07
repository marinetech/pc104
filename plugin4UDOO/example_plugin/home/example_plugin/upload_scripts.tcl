#!/usr/bin/expect  --
# Copyright (c) 2016 Regents of the SIGNET lab, University of Padova.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the University of Padova (SIGNET lab) nor the 
#    names of its contributors may be used to endorse or promote products 
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Author: Filippo Campagnaro
# email: campagn1@dei.unipd.it
# place it in /usr/local/bin/upload_files.tcl
# Breif description: script to upload files of an user
set src_name "pc104"
set src_address "192.168.100.98"
set src_pass "pc104"
set src_folder "pc104_2udoo"

set dest_name "themo_user"
#set dest_address "192.168.100.11"
set dest_pass "themo_pass"
set dest_folder "script"

if {$argc < 1} {
    puts "The script requires at least one input:"
    puts "- dest_address "
    puts "example: ./upload_scripts.tcl dest_address"
    puts "Please try again."
    return
} else {
    set dest_address [lindex $argv 0]
}

spawn bash -c "ssh -A -t $src_name@${src_address} rsync --remove-source-files -r ~/$src_folder/* $dest_name@${dest_address}:${dest_folder}/."
expect {           
    -re ".*$src_name\@$src_address.*password:" {
        send "$src_pass\r"
        set timeout -1
        exp_continue
    } -re ".*$dest_name\@$dest_address.*password:" {
        send "$dest_pass\r"
        set timeout -1
        exp_continue
    } -re {(.*)yes/no\)?} {
        send "yes\r"
        set timeout -1
        exp_continue
    } timeout {

    } -re  {
        exp_continue
    } eof {
      
    }
}
exit
