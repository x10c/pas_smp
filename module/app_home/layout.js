/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_app_home;
var m_app_home_d		= _g_root +'/module/app_home/';

function M_HomeWinChange(title, form_old_title, form_new_title, form_new_confirm_title, form_type, url)
{
	this.type	= form_type;
	this.url	= url;

	this.form_old = new Ext.form.TextField({
			fieldLabel	:form_old_title
		,	inputType	:form_type
		,	width		:200
		});

	this.form_new = new Ext.form.TextField({
			fieldLabel	:form_new_title
		,	inputType	:form_type
		,	allowBlank	:false
		,	width		:200
		});

	this.form_new_confirm = new Ext.form.TextField({
			fieldLabel	:form_new_confirm_title
		,	inputType	:form_type
		,	allowBlank	:false
		,	width		:200
		});

	this.btn_cancel = new Ext.Button({
			text	:'Batal'
		,	iconCls	:'del16'
		,	scope	:this
		,	handler	:function() {
				this.do_cancel();
			}
	});

	this.btn_save = new Ext.Button({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	scope		: this
		,	handler		: function() {
				this.do_save();
			}
		});

	this.win = new Ext.Window({
		title		:title
	,	modal		:true
	,	layout		:'form'
	,	labelAlign	:'left'
	,	padding		:6
	,	closable	:false
	,	resizable	:false
	,	plain		:true
	,	autoHeight	:true
	,	width		:340
	,	items		:[
			this.form_old
		,	this.form_new
		,	this.form_new_confirm
		]
	,	bbar		: [
			this.btn_cancel, '->'
		,	this.btn_save
		]
	});

	this.do_cancel = function()
	{
		this.win.hide();
	}

	this.is_form_valid = function()
	{
		if (this.type == 'password') {
			if (!this.form_old.isValid()) {
				Ext.Msg.alert('Kesalahan', 'Data yang anda inputkan kosong atau tidak sesuai format yang ditentukan!');
				return false;
			}
		}
		
		if (!this.form_new.isValid()) {
			Ext.Msg.alert('Kesalahan', 'Data yang anda inputkan kosong atau tidak sesuai format yang ditentukan!');
			return false;
		}

		if (!this.form_new_confirm.isValid()) {
			Ext.Msg.alert('Kesalahan', 'Data yang anda inputkan kosong atau tidak sesuai format yang ditentukan!');
			return false;
		}

		if (this.form_new.getValue() != this.form_new_confirm.getValue()) {
			Ext.Msg.alert('Kesalahan', 'Kata Kunci Baru tidak sesuai dengan Konfirmasinya!');
			return false;
		}
		
		return true;
	}

	this.do_save = function(record)
	{
		if (!this.is_form_valid()) {
			return;
		}

		var lama_v	= this.form_old.getValue();
		var baru_v	= this.form_new.getValue();
		var lama	= ''
		var baru	= '';

		if (this.type == 'password') {
			lama	= Sha256.hash(lama_v);
			baru	= Sha256.hash(baru_v);
		} else {
			lama	= lama_v;
			baru	= baru_v;
		}

		Ext.Ajax.request({
			params  :{
				lama	: lama
			,	baru	: baru
			}
		,	url		:this.url
		,	scope	:this
		,	waitMsg	:'Mohon Tunggu ...'
		,	success :function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan Kesalahan'
							, msg.info);
					return;
				}

				if (this.type == 'email') {
					_g_usermail = baru;
				}

				this.win.hide();
			}
		});
	}
}

function M_Home()
{
	this.win_pass = new M_HomeWinChange(
			'Penggantian Kata Kunci'
		,	'Kata Kunci Lama'
		,	'Kata Kunci Baru'
		,	'Konfirmasi Kata Kunci Baru'
		,	'password'
		,	m_app_home_d +'submit_change_password.jsp'
		);

	this.menu = new Ext.menu.Menu({
		items	:[
			{
				text	: 'Ganti Kata Kunci'
			,	scope	: this
			,	handler	: function (b,e) {
					this.do_change_password()
				}
			}
		]
	});

	this.btn_my_account = new Ext.SplitButton({
		text	:'My Account'
	,	menu	: this.menu
	});

	this.btn_thn_periode = new Ext.Button({
			text	: 'Tahun Pelajaran dan Periode Belajar'
		,	iconCls	: 'export16'
		,	handler	: function(b, e) {
				showTahunAjaran()
			}
	});
	
	this.panel = new Ext.Panel({
		id				:'app_home_panel'
	,	layout			: 'card'
	,	autoScroll		:true
	,	bodyBorder		:false
	,	frame			:false
	,	tbar			:[
			this.btn_my_account
		,	'->'
		,	this.btn_thn_periode
		]
	});

	this.do_change_password = function()
	{
		this.win_pass.win.show();
	}

	this.do_refresh = function(ha_level)
	{
		this.panel.layout.setActiveItem(0);
	}
}

m_app_home = new M_Home();

//@ sourceURL=app_home.layout.js
