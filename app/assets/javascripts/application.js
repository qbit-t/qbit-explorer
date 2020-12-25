// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
// document.getElementById("info").innerHTML = 'aaa';
console.log("start");
//document.getElementById("shardes").children[0].click();

window.onload = function(){
  console.log("load");
  document.getElementById("shardes").children[0].children[0].click();
  document.getElementById("info").innerHTML = 'aaaa';
};

function select_shard(chain, height)
{
  console.log("select");
  shardes = document.getElementById("shardes");
  for(i = 0; i < shardes.children.length; i++)
  {
    shardes.children[i].classList.remove('active');
  }
  document.getElementById(chain).classList.add('active');
  document.getElementById("height").innerHTML = height;
  document.getElementById("info").innerHTML = chain;
}

