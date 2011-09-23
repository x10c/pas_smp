/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_adm_adm_akademik_pindah_kelas;
var m_adm_adm_adm_akademik_pindah_kelas_master;
var m_adm_adm_adm_akademik_pindah_kelas_detail;
var m_adm_adm_adm_akademik_pindah_kelas_d = _g_root +'/module/adm_adm_adm_akademik_pindah_kelas/';
var m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran = '';
var m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas = '';
var m_adm_adm_adm_akademik_pindah_kelas_ha_level = 0;

function m_adm_adm_adm_akademik_pindah_kelas_master_on_select_load_detail()
{
 	if (typeof m_adm_adm_adm_akademik_pindah_kelas_master == 'undefined'
	||  typeof m_adm_adm_adm_akademik_pindah_kelas_detail == 'undefined'
	||	m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran == ''
	||	m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas == '') {
		return;
	}

	m_adm_adm_adm_akademik_pindah_kelas_detail.do_refresh();
}

function M_AdmAdmAdmAkademikPindahKelasMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_adm_adm_akademik_pindah_kelas_d +'data_master.jsp'
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
							m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran = data[0].data['kd_tahun_ajaran'];
							m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas = data[0].data['kd_tingkat_kelas'];
						} else {
							m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran = '';
							m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas = '';
						}

						m_adm_adm_adm_akademik_pindah_kelas_master_on_select_load_detail();
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

		m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran = '';
		m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas = '';
		
		m_adm_adm_adm_akademik_pindah_kelas_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_adm_adm_adm_akademik_pindah_kelas_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmAdmAdmAkademikPindahKelasDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_siswa' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_adm_adm_akademik_pindah_kelas_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.store_rombel = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_adm_adm_akademik_pindah_kelas_d +'data_ref_rombel.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_rombel = new Ext.form.ComboBox({
			store			: this.store_rombel
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
		,	{ header		: 'NIS'
			, dataIndex		: 'nis'
			, sortable		: true
			, editable		: false
			, align			: 'center'
			, width			: 150
			}
		,	{ id			: 'nm_siswa'
			, header		: 'Nama Siswa'
			, dataIndex		: 'nm_siswa'
			, sortable		: true
			, editable		: false
			}
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, editable		: false
			, align			: 'center'
			, width			: 100
			}
		,	{ header		: 'Wali Kelas'
			, dataIndex		: 'kd_rombel'
			, sortable		: true
			, editor		: this.form_rombel
			, renderer		: combo_renderer(this.form_rombel)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_rombel
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
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
		,	tbar		: this.tbar
		,	autoExpandColumn: 'nm_siswa'
		,	listeners	: {
					scope		: this
				,	rowclick	: function (g, r, e) {
						return this.do_edit(r);
					}
			}
	});

	this.do_edit = function(row)
	{
		if (m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran == '' 
		|| m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		if (m_adm_adm_adm_akademik_pindah_kelas_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
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
						kd_tahun_ajaran		: m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran
					,	kd_tingkat_kelas	: m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas
					,	kd_rombel			: record.data['kd_rombel']
					,	id_siswa			: record.data['id_siswa']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_adm_adm_akademik_pindah_kelas_d +'submit.jsp'
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

	this.do_load = function()
	{
		this.store_rombel.load({
				params		: {
					kd_tahun_ajaran		: m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas
				}
			,	callback	: function(){
					this.store.load({
						params	: {
							kd_tahun_ajaran		: m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran
						,	kd_tingkat_kelas	: m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas
						}
					});
				}
			,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_adm_adm_akademik_pindah_kelas_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmAdmAdmAkademikPindahKelas()
{
	m_adm_adm_adm_akademik_pindah_kelas_master	= new M_AdmAdmAdmAkademikPindahKelasMaster('Tingkat Kelas');
	m_adm_adm_adm_akademik_pindah_kelas_detail	= new M_AdmAdmAdmAkademikPindahKelasDetail('Penentuan Kelas Siswa');
	
	this.panel = new Ext.Panel({
			id			: 'adm_adm_adm_akademik_pindah_kelas_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_adm_adm_adm_akademik_pindah_kelas_master.grid
			,	m_adm_adm_adm_akademik_pindah_kelas_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_adm_adm_adm_akademik_pindah_kelas_ha_level	= ha_level;
		m_adm_adm_adm_akademik_pindah_kelas_kd_tahun_ajaran = '';
		m_adm_adm_adm_akademik_pindah_kelas_kd_tingkat_kelas = '';

		m_adm_adm_adm_akademik_pindah_kelas_master.do_refresh(ha_level);
	}

}

m_adm_adm_adm_akademik_pindah_kelas = new M_AdmAdmAdmAkademikPindahKelas();

//@ sourceURL=adm_adm_adm_akademik_pindah_kelas.layout.js
