#!/usr/bin/perl
package SU;

use a2b;
use cat;
use cp;
use flow;
use manage_files_by;
use manage_files_by2;
use message;
use mkparfile;
#use plot;
use readfiles;
use segdread;
use seismics;
#use writefiles;
use suaddhead;
use suamp;
use sucat;
use suchw;
use sudipfilt;
use suinterp;
use suifft;
use sufilter;
use suflip;
use sugain;
use sukill;
use sugain;
use sugethw;
use sumute;
use sunmo;
use suop;
use suop2;
use smooth2;
use suresamp;
use suspecfk;
use suphasevel;
use supolar;
use suresstat;
use surms;
use sushw;
use susort;
use suspecfx;
use sustack;
use sustatic;
use suinterp;
use suvelan;
#use Suximage;
use suximage;
use suwind;
use suxwigb;
use xgraph;
use SuMessages;
#todo
#use suxgraph;

=pod

the following may use previous packages
IVA2 depends on SuMessages;

=cut 

use System_Variables;
use iSuvelan;
use iSunmo;
use iWrite_All_iva_out;
use iVpicks2par;
use iVrms2Vint;
use IVA2_Tk;
use IVA2; 
use iSelect_tr_Sumute_top3;
use iTopMutePicks2par3;
use iSave_top_mute_picks3;
use iApply_top_mute3;
#use itemp_Sumute_top3;
use old_data;
#use readParams;
#use localParams;
use iTop_Mute3;
#
# the following are home-grown
use xk;
#use readParams;
#use radio_button_widget;

1;
