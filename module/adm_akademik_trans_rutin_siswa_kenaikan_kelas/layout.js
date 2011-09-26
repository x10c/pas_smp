/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas;
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master;
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa;
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un;
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran = '';
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas = '';
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel = '';
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_periode_belajar = '';
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d = _g_root +'/module/adm_akademik_trans_rutin_siswa_kenaikan_kelas/';
var m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level = 0;

function m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master_on_select_load_detail()
{
 	if (typeof m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master == 'undefined'
	||  typeof m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa == 'undefined'
	||  typeof m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un == 'undefined'
	||	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran == ''
	||	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas == ''
	||	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel == '') {
		return;
	}

	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.do_refresh();
	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un.do_refresh();
}

function M_AdmAkademikTransRutinSiswaKenaikanKelasDetailKenaikanKelas(title)
{
	this.title		= title;

	this.records = [
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'kd_lulus', type : 'bool' }
		,	{ name	: 'no_ijazah' }
	];

	this.reader = new Ext.data.JsonReader(
			{ root:'rows'}
		,	this.records
	);

	this.store = new Ext.data.Store({
			url			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'data_detail_kenaikan_siswa.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});

	this.checkColumn = new Ext.grid.CheckColumn({
			header		: 'Naik Kelas / Lulus'
		,	dataIndex	: 'kd_lulus'
		,	width		: 150
	});

	this.form_no_ijazah = new Ext.form.TextField({
			allowBlank	: false
	});
	
	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer({width:30})
		,{
			header		:'NIS'
		,	dataIndex	:'nis'
		,	align		:'center'
		,	width		: 150
		,	filterable	: true
		},{ 
			id			: 'nm_siswa'
		,	header		: 'Nama Siswa'
		, 	dataIndex	: 'nm_siswa'
		, 	filterable	: true
		},
			this.checkColumn
		,{
			header		:'No.Ijazah'
		,	dataIndex	:'no_ijazah'
		,	editor		: this.form_no_ijazah
		,	width		: 200
		,	filterable	: true
		}
		]
	,	defaults	:{
			sortable	:true
		,	hideable	:false
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

	this.btn_save = new Ext.Button({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_save();
			}
	});

	this.btn_mark = new Ext.Button({
			text		: 'Berikan Semua Tanda'
		,	iconCls		: 'upload16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_mark();
			}	
	});

	this.btn_process = new Ext.Button({
			text		: '<b>Kenaikan Kelas</b>'
		,	iconCls		: 'dirup16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_process();
			}	
	});
	
	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_save
		]
	});

	this.bbar = new Ext.Toolbar({
		items	: [
			this.btn_process
		,	'->'
		,	this.btn_mark
		]
	});

	this.panel = new Ext.grid.EditorGridPanel({
			title				: this.title
		,	store				: this.store
		,	cm					: this.cm
		,	stripeRows			: true
		,	columnLines			: true
		,	clickToEdit			: 1
		,	plugins				: [this.checkColumn, this.filters]
		,	tbar				: this.tbar
		,	bbar				: this.bbar
		,	autoExpandColumn	: 'nm_siswa'
	});

	this.do_mark = function()
	{
		this.store.each(
			function(r) {
				r.set('kd_lulus', 'true');
			}
		, 	this
		);
	}

	this.do_process = function()
	{
		Ext.MessageBox.confirm('Konfirmasi', 'Kenaikan Kelas?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 5;
				Ext.Ajax.request({
						params  : {
								kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran
							,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas
							,	kd_rombel			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel
							,	dml_type			: this.dml_type
						}
					,	url		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'submit.jsp'
					,	waitMsg	: 'Mohon Tunggu ...'
					,	success :
							function (response)
							{
								var msg = Ext.util.JSON.decode(response.responseText);

								if (msg.success == false) {
									Ext.MessageBox.alert('Pesan', msg.info);
								} else {
									Ext.Msg.alert('Informasi', msg.info);
									
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_process.setDisabled(true);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_mark.setDisabled(true);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_save.setDisabled(true);
								}
							}
					,	scope	: this
				});	
			}
		});
	}
	
	this.do_save = function()
	{
		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var i;
		
		main_load.show();
		
		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ id_siswa :  "+ mods[i].get('id_siswa')
					+ ", kd_lulus : '"+ mods[i].get('kd_lulus') +"' "
					+ ", no_ijazah : '"+ mods[i].get('no_ijazah') +"' ";

			data +="}";
		}
		data +="]";

		Ext.Ajax.request({
				url		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'submit_detail_kenaikan_siswa.jsp'
			,	params  : {
					kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas
				,	kd_rombel			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel
				,	rows				: data
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.Msg.alert('Gagal', response.responseText);
					main_load.hide();
				}
			,	success : function (response){
					var msg = Ext.util.JSON.decode(response.responseText);
					
					main_load.hide();

					if (msg.success == false) {
						Ext.Msg.alert('Kesalahan', msg.info);
					} else {
						Ext.Msg.alert('Informasi', msg.info);
						this.do_load();
					}
				}
			,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran
			,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas
			,	kd_rombel			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level > 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmAkademikTransRutinSiswaKenaikanKelasDetailPesertaUN(title)
{
	this.title		= title;

	this.records = [
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'kd_ebta', type : 'bool' }
		,	{ name	: 'no_uan' }
	];

	this.reader = new Ext.data.JsonReader(
			{ root:'rows'}
		,	this.records
	);

	this.store = new Ext.data.Store({
			url			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'data_detail_peserta_un.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});

	this.checkColumn = new Ext.grid.CheckColumn({
			header		: 'Peserta UN'
		,	dataIndex	: 'kd_ebta'
		,	width		: 150
	});

	this.form_no_uan = new Ext.form.TextField({
			allowBlank	: false
	});
	
	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer({width:30})
		,{
			header		:'NIS'
		,	dataIndex	:'nis'
		,	align		:'center'
		,	width		: 150
		,	filterable	: true
		},{ 
			id			: 'nm_siswa'
		,	header		: 'Nama Siswa'
		, 	dataIndex	: 'nm_siswa'
		, 	filterable	: true
		},
			this.checkColumn
		,{
			header		:'No.UN'
		,	dataIndex	:'no_uan'
		,	editor		: this.form_no_uan
		,	width		: 200
		,	filterable	: true
		}
		]
	,	defaults	:{
			sortable	:true
		,	hideable	:false
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

	this.btn_save = new Ext.Button({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_save();
			}
	});

	this.btn_mark = new Ext.Button({
			text		: 'Berikan Semua Tanda'
		,	iconCls		: 'upload16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_mark();
			}	
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_save
		]
	});

	this.bbar = new Ext.Toolbar({
		items	: [
			'->'
		,	this.btn_mark
		]
	});

	this.panel = new Ext.grid.EditorGridPanel({
			id					: 'm_adm_akademik_trans_rutin_siswa_kenaikan_kelas_penentuan_un_panel'
		,	title				: this.title
		,	store				: this.store
		,	cm					: this.cm
		,	stripeRows			: true
		,	columnLines			: true
		,	clickToEdit			: 1
		,	plugins				: [this.checkColumn, this.filters]
		,	tbar				: this.tbar
		,	bbar				: this.bbar
		,	autoExpandColumn	: 'nm_siswa'
	});

	this.do_mark = function()
	{
		this.store.each(
			function(r) {
				r.set('kd_ebta', 'true');
			}
		, 	this
		);
	}

	this.do_save = function()
	{
		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var i;
		
		main_load.show();
		
		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ id_siswa :  "+ mods[i].get('id_siswa')
					+ ", kd_ebta : '"+ mods[i].get('kd_ebta') +"' "
					+ ", no_uan : '"+ mods[i].get('no_uan') +"' ";

			data +="}";
		}
		data +="]";

		Ext.Ajax.request({
				url		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'submit_detail_peserta_un.jsp'
			,	params  : {
					kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas
				,	kd_rombel			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel
				,	rows				: data
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.Msg.alert('Gagal', response.responseText);
					main_load.hide();
				}
			,	success : function (response){
					var msg = Ext.util.JSON.decode(response.responseText);
					
					main_load.hide();

					if (msg.success == false) {
						Ext.Msg.alert('Kesalahan', msg.info);
					} else {
						Ext.Msg.alert('Informasi', msg.info);
						this.do_load();
					}
				}
			,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran
			,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas
			,	kd_rombel			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level > 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmAkademikTransRutinSiswaKenaikanKelasMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_pegawai' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'id_ruang_kelas' }
		,	{ name	: 'nm_ruang_kelas' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'data_master.jsp'
		,	autoLoad	: false
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Rombel'
			, dataIndex		: 'kd_rombel'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Wali Kelas'
			, dataIndex		: 'nm_pegawai'
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Ruang Kelas'
			, dataIndex		: 'nm_ruang_kelas'
			, width			: 100
			, filterable	: true
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, filterable	: true
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran 	= data[0].data['kd_tahun_ajaran'];
						m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas 	= data[0].data['kd_tingkat_kelas'];
						m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel 			= data[0].data['kd_rombel'];
						
						if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_periode_belajar == '2'){
							m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.setDisabled(false);
							m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.unhideTabStripItem(0);
							m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.setActiveTab(0);
							if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas != '03'){
								m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.setActiveTab(0);
								m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.hideTabStripItem(1);
								m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.panel.getColumnModel().setHidden(4, true);
							} else {
								m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.setActiveTab(0);
								m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.unhideTabStripItem(1);
								m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.panel.getColumnModel().setHidden(4, false);
							}
						} else {
							m_adm_akademik_trans_rutin_siswa_kenaikan_kelas.panel_detail.setDisabled(true);
						}

						Ext.Ajax.request({
							url		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'data_status_naik_kelas.jsp'
						,	params	: {
									kd_tahun_ajaran		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran
								,	kd_tingkat_kelas	: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas
								,	kd_rombel			: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel
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

								if (msg.status_naik_kelas > '2'){
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_process.setDisabled(true);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_mark.setDisabled(true);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_save.setDisabled(true);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un.btn_mark.setDisabled(true);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un.btn_save.setDisabled(true);
								} else {
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_process.setDisabled(false);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_mark.setDisabled(false);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.btn_save.setDisabled(false);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un.btn_mark.setDisabled(false);
									m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un.btn_save.setDisabled(false);
								}
							}
						,	scope	: this
						});
					} else {
						m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tahun_ajaran 	= '';
						m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_tingkat_kelas 	= '';
						m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_rombel 			= '';
					}
					
					m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master_on_select_load_detail();
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

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'keterangan'
	});

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmAkademikTransRutinSiswaKenaikanKelas()
{
	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master					= new M_AdmAkademikTransRutinSiswaKenaikanKelasMaster('Kenaikan Kelas');
	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa	= new M_AdmAkademikTransRutinSiswaKenaikanKelasDetailKenaikanKelas('Kenaikan Siswa');
	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un		= new M_AdmAkademikTransRutinSiswaKenaikanKelasDetailPesertaUN('Penentuan Peserta UN');

	this.panel_detail = new Ext.TabPanel({
			enableTabScroll	: true
		,	region			: 'center'
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
		,	items			: [
				m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_kenaikan_siswa.panel
			,	m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_detail_peserta_un.panel
			]
	});

	this.panel = new Ext.Panel({
			id				: 'adm_akademik_trans_rutin_siswa_kenaikan_kelas_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoWidth		: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master.panel
			,	this.panel_detail
			]
	});

	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_d +'data_periode_belajar.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_periode_belajar = msg.kd_periode_belajar;
				
				if (m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_kd_periode_belajar == '2'){
					this.panel_detail.setDisabled(false);
				} else {
					this.panel_detail.setDisabled(true);
				}
			}
		,	scope	: this
		});
	}
	
	this.do_refresh = function(ha_level)
	{
		this.do_check();
		
		m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_ha_level = ha_level;
		
		m_adm_akademik_trans_rutin_siswa_kenaikan_kelas_master.do_refresh();
	}
}

m_adm_akademik_trans_rutin_siswa_kenaikan_kelas = new M_AdmAkademikTransRutinSiswaKenaikanKelas();

//@ sourceURL=adm_akademik_trans_rutin_siswa_kenaikan_kelas.layout.js
