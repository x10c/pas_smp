/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan;
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master;
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail;
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d = _g_root +'/module/adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan/';
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran = '';
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas = '';
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level = 0;

function m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master_on_select_load_detail()
{
 	if (typeof m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master == 'undefined'
	||  typeof m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail == 'undefined'
	||	m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran == ''
	||	m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas == '') {
		return;
	}

	m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail.do_refresh();
}

function M_AdmAkademikTransRutinSiswaPenentuanSiswaPindahanMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d +'data_master.jsp'
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
							m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran = data[0].data['kd_tahun_ajaran'];
							m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas = data[0].data['kd_tingkat_kelas'];
						} else {
							m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran = '';
							m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas = '';
						}

						m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master_on_select_load_detail();
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

		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran = '';
		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas = '';
		
		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmAkademikTransRutinSiswaPenentuanSiswaPindahanDetail(title)
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
		,	url			: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.store_rombel = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d +'data_ref_rombel.jsp'
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

	this.btn_process = new Ext.Button({
			text	: '<b>Penentuan Kelas Selesai</b>'
		,	iconCls	: 'dirup16'
		,	scope	: this
		,	handler	: function() {
				this.do_process();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.bbar = new Ext.Toolbar({
		items	: [
			this.btn_process
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
		,	bbar		: this.bbar
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
		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran == '' 
		|| m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_process = function()
	{
		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran == '' 
		|| m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Penentuan Kelas Selesai?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 5;
				Ext.Ajax.request({
						params  : {
								kd_tahun_ajaran		: ''
							,	kd_tingkat_kelas	: ''
							,	kd_rombel			: ''
							,	id_siswa			: ''
							,	dml_type			: this.dml_type
						}
					,	url		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d +'submit.jsp'
					,	waitMsg	: 'Mohon Tunggu ...'
					,	success :
							function (response)
							{
								var msg = Ext.util.JSON.decode(response.responseText);

								if (msg.success == false) {
									Ext.MessageBox.alert('Pesan', msg.info);
								}

								m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail.do_load();
							}
					,	scope	: this
				});	
			}
		});
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
		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran
					,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas
					,	kd_rombel			: record.data['kd_rombel']
					,	id_siswa			: record.data['id_siswa']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d +'submit.jsp'
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

	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_d +'data_check.jsp'
		,	params	: {
					kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				if (msg.jumlah < 1){
					this.btn_process.setDisabled(true);
				} else {
					this.btn_process.setDisabled(false);
				}
			}
		,	scope	: this
		});
	}
	
	this.do_load = function()
	{
		this.store_rombel.load({
				params		: {
					kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas
				}
			,	callback	: function(){
					this.store.load({
						params	: {
							kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran
						,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas
						}
					});
				}
			,	scope		: this
		});

		this.do_check();
	}

	this.do_refresh = function()
	{
		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level > 1) {
			this.btn_process.setDisabled(false);
		} else {
			this.btn_process.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmAkademikTransRutinSiswaPenentuanSiswaPindahan()
{
	m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master	= new M_AdmAkademikTransRutinSiswaPenentuanSiswaPindahanMaster('Tingkat Kelas');
	m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail	= new M_AdmAkademikTransRutinSiswaPenentuanSiswaPindahanDetail('Penentuan Kelas Siswa Pindahan');
	
	this.panel = new Ext.Panel({
			id			: 'adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master.grid
			,	m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_ha_level	= ha_level;
		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tahun_ajaran = '';
		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_kd_tingkat_kelas = '';

		m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan_master.do_refresh(ha_level);
	}

}

m_adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan = new M_AdmAkademikTransRutinSiswaPenentuanSiswaPindahan();

//@ sourceURL=adm_akademik_trans_rutin_siswa_penentuan_siswa_pindahan.layout.js
