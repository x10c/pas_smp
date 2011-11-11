/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_sekolah_kesiswaan_pekerjaan_orangtua;
var m_ref_sekolah_kesiswaan_pekerjaan_orangtua_d = _g_root +'/module/ref_sekolah_kesiswaan_pekerjaan_orangtua/';

function M_RefSekolahKesiswaanPekerjaanOrangtua(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_gol_pekerjaan_ortu' }
		,	{ name	: 'nm_gol_pekerjaan_ortu' }
		,	{ name	: 'kd_pekerjaan_ortu' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_sekolah_kesiswaan_pekerjaan_orangtua_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.store_pekerjaan_ortu = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_sekolah_kesiswaan_pekerjaan_orangtua_d +'data_pekerjaan_ortu.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_pekerjaan_ortu = new Ext.form.ComboBox({
			store			: this.store_pekerjaan_ortu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_nm_gol_pekerjaan_ortu = new Ext.form.TextField({
		allowBlank	: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Pekerjaan Orangtua'
			, dataIndex		: 'kd_pekerjaan_ortu'
			, sortable		: true
			, editor		: this.form_pekerjaan_ortu
			, renderer		: combo_renderer(this.form_pekerjaan_ortu)
			, align			: 'center'
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_pekerjaan_ortu
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'nm_gol_pekerjaan_ortu'
			, header		: 'Nama Golongan Pekerjaan Orangtua'
			, dataIndex		: 'nm_gol_pekerjaan_ortu'
			, sortable		: true
			, editor		: this.form_nm_gol_pekerjaan_ortu
			, filterable	: true
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
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
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
			id			: 'ref_sekolah_kesiswaan_pekerjaan_orangtua_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_gol_pekerjaan_ortu'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_gol_pekerjaan_ortu	: ''
			,	nm_gol_pekerjaan_ortu	: ''
			,	kd_pekerjaan_ortu		: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
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

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		if (this.ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_gol_pekerjaan_ortu	: record.data['id_gol_pekerjaan_ortu']
					,	nm_gol_pekerjaan_ortu	: record.data['nm_gol_pekerjaan_ortu']
					,	kd_pekerjaan_ortu		: record.data['kd_pekerjaan_ortu']
					,	dml_type				: this.dml_type
				}
			,	url		: m_ref_sekolah_kesiswaan_pekerjaan_orangtua_d +'submit.jsp'
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
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
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

	this.do_load = function()
	{
		this.store_pekerjaan_ortu.load({
				callback	: function(){
					this.store.load();
				}
			,	scope		: this
		});
		
		this.set_button();
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

		this.do_load();
	}
}

m_ref_sekolah_kesiswaan_pekerjaan_orangtua = new M_RefSekolahKesiswaanPekerjaanOrangtua('Pekerjaan ortu');

//@ sourceURL=m_ref_sekolah_kesiswaan_pekerjaan_orangtua.layout.js
