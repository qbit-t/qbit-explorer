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
  //document.getElementById("info").innerHTML = 'aaaa';
};

function select_shard(chain, height, dapp, status)
{
  console.log("select");
  shardes = document.getElementById("shardes");
  for(i = 0; i < shardes.children.length; i++)
  {
    shardes.children[i].classList.remove('active');
  }
  document.getElementById(chain).classList.add('active');
  document.getElementById("chain").innerHTML = chain;
  document.getElementById("height").innerHTML = height;
  document.getElementById("dapp").innerHTML = dapp;
  document.getElementById("status").innerHTML = status;
  blocks = document.getElementById("blocks");
  for(i = 0; i < blocks.children.length; i++)
  {
    blocks.children[i].style.visibility = "collapse";
  }
  block = document.getElementById("blocks-" + chain);
  block.style.visibility = "visible";
  block.style.position = "absolute";
  block.style.top = "400px";
}

function select_asset(type, entity, balance, income, outgoing)
{
  assets = document.getElementById("assets");
  for(i = 0; i < assets.children.length; i++)
  {
    assets.children[i].classList.remove('active');
  }

  document.getElementById(type).classList.add('active');
  document.getElementById("type").innerHTML = type;
  document.getElementById("entity").innerHTML = entity;
  document.getElementById("balance").innerHTML = balance;
  document.getElementById("income").innerHTML = income;
  document.getElementById("outgoing").innerHTML = outgoing;
}

