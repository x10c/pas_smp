/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_sekolah_akademik_kurikulum_muatan_lokal;
var m_ref_sekolah_akademik_kurikulum_muatan_lokal_master;
var m_ref_sekolah_akademik_kurikulum_muatan_lokal_detail;
var m_ref_sekolah_akademik_kurikulum_muatan_lokal_d = _g_root +'/module/ref_sekolah_akademik_kurikulum_muatan_lokal/';
var m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum = '';
var m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas = '';
var m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level = 0;

function m_ref_sekolah_akademik_kurikulum_muatan_lokal_master_on_select_load_detail()
{
 	if (typeof m_ref_sekolah_akademik_kurikulum_muatan_lokal_master == 'undefined'
	||  typeof m_ref_sekolah_akademik_kurikulum_muatan_lokal_detail == 'undefined'
	||	m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum == ''
	||	m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas == '') {
		return;
	}

	m_ref_sekolah_akademik_kurikulum_muatan_lokal_detail.do_refresh();
}

function M_RefSekolahAkademikKurikulumMuatanLokalMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_kurikulum' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_sekolah_akademik_kurikulum_muatan_lokal_d +'data_master.jsp'
		,	autoLoad	: false
	});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_tingkat_kelas'
			, header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum		= data[0].data['kd_kurikulum'];
							m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas	= data[0].data['kd_tingkat_kelas'];
						} else {
							m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum		= '';
							m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas	= '';
						}

						m_ref_sekolah_akademik_kurikulum_muatan_lokal_master_on_select_load_detail();
					}
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nm_tingkat_kelas'
	});

	this.do_load = function()
	{
		this.store.load();

		m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum	= '';
		m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas	= '';
		
		m_ref_sekolah_akademik_kurikulum_muatan_lokal_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefSekolahAkademikKurikulumMuatanLokalDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_kurikulum' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_periode_belajar' }
		,	{ name	: 'kd_mata_pelajaran_diajarkan' }
		,	{ name	: 'status_ciri_khas' }
		,	{ name	: 'uan' }
		,	{ name	: 'elemen' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_sekolah_akademik_kurikulum_muatan_lokal_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.store_mata_pelajaran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_sekolah_akademik_kurikulum_muatan_lokal_d +'data_ref_mata_pelajaran.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_mata_pelajaran = new Ext.form.ComboBox({
			store			: this.store_mata_pelajaran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Mata Pelajaran'
			, dataIndex		: 'kd_mata_pelajaran_diajarkan'
			, sortable		: true
			, editor		: this.form_mata_pelajaran
			, renderer		: combo_renderer(this.form_mata_pelajaran)
			, width			: 400
			, filter		: {
					type		: 'list'
				,	store		: this.store_mata_pelajaran
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
					if (data.length && m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level == 4) {
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

	this.grid = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	listeners	: {
					scope		: this
				,	rowclick	: function (g, r, e) {
						return this.do_edit(r);
					}
			}
	});

	this.do_add = function()
	{
		this.form_mata_pelajaran.setDisabled(false);
		
		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum == '' || m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				kd_kurikulum				: ''
			,	kd_tingkat_kelas			: ''
			,	kd_periode_belajar			: ''
			,	kd_mata_pelajaran_diajarkan	: ''
			,	status_ciri_khas			: ''
			,	uan							: ''
			,	elemen						: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum == '' || m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

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
		
		this.form_mata_pelajaran.setDisabled(false);
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				params  : {
						kd_kurikulum				: m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum
					,	kd_tingkat_kelas			: m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas
					,	kd_periode_belajar			: '1'
					,	kd_mata_pelajaran_diajarkan	: record.data['kd_mata_pelajaran_diajarkan']
					,	status_ciri_khas			: '0'
					,	uan							: '0'
					,	elemen						: 12
					,	dml_type					: this.dml_type
				}
			,	url		: m_ref_sekolah_akademik_kurikulum_muatan_lokal_d +'submit.jsp'
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
		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum == '' || m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level >= 3) {
			this.dml_type = 3;
			this.form_mata_pelajaran.setDisabled(true);
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_mata_pelajaran.load({
				callback	: function(){
					this.store.load({
						params	: {
								kd_kurikulum		: m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum
							,	kd_tingkat_kelas	: m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas
						}
					});
				}
			,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
		
		this.form_mata_pelajaran.setDisabled(false);
	}

}

function M_RefSekolahAkademikKurikulumMuatanLokal()
{
	m_ref_sekolah_akademik_kurikulum_muatan_lokal_master	= new M_RefSekolahAkademikKurikulumMuatanLokalMaster('Tingkat Kelas');
	m_ref_sekolah_akademik_kurikulum_muatan_lokal_detail	= new M_RefSekolahAkademikKurikulumMuatanLokalDetail('Mata Pelajaran Muatan Lokal');
	
	this.panel = new Ext.Panel({
			id			: 'ref_sekolah_akademik_kurikulum_muatan_lokal_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_ref_sekolah_akademik_kurikulum_muatan_lokal_master.grid
			,	m_ref_sekolah_akademik_kurikulum_muatan_lokal_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_sekolah_akademik_kurikulum_muatan_lokal_ha_level	= ha_level;
		m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_kurikulum = '';
		m_ref_sekolah_akademik_kurikulum_muatan_lokal_kd_tingkat_kelas = '';

		m_ref_sekolah_akademik_kurikulum_muatan_lokal_master.do_refresh(ha_level);
	}

}

m_ref_sekolah_akademik_kurikulum_muatan_lokal = new M_RefSekolahAkademikKurikulumMuatanLokal();

//@ sourceURL=ref_sekolah_akademik_kurikulum_muatan_lokal.layout.js
