/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_app_adm_user;
var m_app_adm_user_d = _g_root +'/module/app_adm_user/';

function M_AppAdmUser(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{name: 'username'}
		,	{name: 'id_grup'}
		,	{name: 'password'}
		,	{name: 'status_user'}
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_app_adm_user_d +'data.jsp'
		,	autoLoad	: false
	});

	this.store_grup = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_app_adm_user_d +'data_grup.jsp'
		,	autoLoad	: false
	});

	this.store_status_user = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				[0, 'Tidak Aktif']
			,	[1, 'Aktif']
			]
	});

	this.form_username = new Ext.form.TextField({
			allowBlank		: false
		,	maxLength		: 20
		,	maxLengthText	: 'Maksimal panjang kolom USERNAME adalah 20'
	});

	this.form_grup = new Ext.form.ComboBox({
			store			: this.store_grup
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	triggerAction	: 'all'
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	allowBlank		: false
	});

	this.form_password = new Ext.form.TextField({
			inputType	: 'password'
		,	allowBlank	: false
	});

	this.form_status_user = new Ext.form.ComboBox({
			store			: this.store_status_user
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	triggerAction	: 'all'
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	allowBlank		: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Nama User'
			, dataIndex		: 'username'
			, sortable		: true
			, editor		: this.form_username
			, width			: 150
			, filterable	: true
			}
		,	{ header		: 'Grup User'
			, dataIndex		: 'id_grup'
			, sortable		: true
			, editor		: this.form_grup
			, renderer		: combo_renderer(this.form_grup)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_grup
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'password'
			, header		: 'Kata Kunci'
			, dataIndex		: 'password'
			, sortable		: true
			, editor		: this.form_password
			}
		,	{ header		: 'Status User'
			, dataIndex		: 'status_user'
			, sortable		: true
			, editor		: this.form_status_user
			, renderer		: combo_renderer(this.form_status_user)
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_status_user
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
	];
	
	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_load();
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'app_adm_user_panel'
		,	title				: 'Daftar User'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.editor, this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'password'
		,	listeners       	: {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit();
					}
			}
	});

	this.set_disabled = function()
	{
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
		this.btn_del.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
		this.btn_del.setDisabled(false);
	}

	this.set_button = function()
	{
		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (this.ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.form_username.setDisabled(false);
		
		this.do_load();
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				username	: ''
			,	id_grup		: ''
			,	password	: ''
			,	status_user	: ''
		});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_edit = function(row)
	{
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			this.form_username.setDisabled(true);
			return true;
		}
		return false;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}
		
		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
	}

	this.do_save = function(record)
	{
		this.set_enabled();

		if (this.ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		var pass	= this.form_password.getValue();
		var passenc	= Sha256.hash(pass, true);

		Ext.Ajax.request({
			url	: m_app_adm_user_d +'submit.jsp'
		,	params  : {
				dml_type	: this.dml_type
			,	username	: record.data['username']
			,	id_grup		: record.data['id_grup']
			,	password	: passenc
			,	status_user	: record.data['status_user']
			}
		,	scope	: this
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
				}
		});
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.form_username.setDisabled(false);
		
		this.set_button();
	}

	this.do_load = function()
	{
		this.store_grup.load({
				callback	: function(){
					this.store.load();
				}
			,	scope		: this
		});
		
		this.set_button();
	}
}

m_app_adm_user = new M_AppAdmUser('Pengaturan User');

//@ sourceURL=app_adm_user.layout.js
