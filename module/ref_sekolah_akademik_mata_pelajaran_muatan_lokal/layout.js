/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_sekolah_akademik_mata_pelajaran_muatan_lokal;
var m_ref_sekolah_akademik_mata_pelajaran_muatan_lokal_d = _g_root +'/module/ref_sekolah_akademik_mata_pelajaran_muatan_lokal/';

function M_RefSekolahAkademikMataPelajaranMuatanLokal(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_mata_pelajaran_diajarkan' }
		,	{ name	: 'nm_mata_pelajaran_diajarkan' }
		,	{ name	: 'kd_kel_mata_pelajaran' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_sekolah_akademik_mata_pelajaran_muatan_lokal_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.form_nm_mata_pelajaran_diajarkan = new Ext.form.TextField({
		allowBlank	: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_mata_pelajaran_diajarkan'
			, header		: 'Nama Mata Pelajaran Muatan Lokal'
			, dataIndex		: 'nm_mata_pelajaran_diajarkan'
			, sortable		: true
			, editor		: this.form_nm_mata_pelajaran_diajarkan
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
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id			: 'ref_sekolah_akademik_mata_pelajaran_muatan_lokal_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_mata_pelajaran_diajarkan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_add = function()
	{
		this.record_new = new this.record({
				kd_mata_pelajaran_diajarkan	: ''
			,	nm_mata_pelajaran_diajarkan	: ''
			,	kd_kel_mata_pelajaran		: '16'
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				params  : {
						kd_mata_pelajaran_diajarkan	: record.data['kd_mata_pelajaran_diajarkan']
					,	nm_mata_pelajaran_diajarkan	: record.data['nm_mata_pelajaran_diajarkan']
					,	kd_kel_mata_pelajaran		: record.data['kd_kel_mata_pelajaran']
					,	dml_type					: this.dml_type
				}
			,	url		: m_ref_sekolah_akademik_mata_pelajaran_muatan_lokal_d +'submit.jsp'
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

	this.do_load = function()
	{
		this.store.load();	
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

		this.do_load();
	}
}

m_ref_sekolah_akademik_mata_pelajaran_muatan_lokal = new M_RefSekolahAkademikMataPelajaranMuatanLokal('Mata Pelajaran Muatan Lokal');

//@ sourceURL=m_ref_sekolah_akademik_mata_pelajaran_muatan_lokal.layout.js
