/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_adm_pegawai_aktifasi;
var m_adm_adm_pegawai_aktifasi_d = _g_root +'/module/adm_adm_pegawai_aktifasi/';

function M_AdmAdmPegawaiAktifasi(title)
{
	this.title		= title;
	this.ha_level	= 0;

	this.records = [
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'id_pegawai' }
		,	{ name	: 'nip' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'nm_jenis_ketenagaan' }
		,	{ name	: 'status_aktif', type : 'bool' }
	];

	this.reader = new Ext.data.JsonReader(
			{ root:'rows'}
		,	this.records
	);

	this.store = new Ext.data.Store({
			url			: m_adm_adm_pegawai_aktifasi_d +'data.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});
	
	this.checkColumn = new Ext.grid.CheckColumn({
			header		: 'Status Aktif'
		,	dataIndex	: 'status_aktif'
		,	width		: 100
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer({width:30})
		,{
			header		:'NIP'
		,	dataIndex	:'nip'
		,	align		:'center'
		,	width		: 150
		,	filterable	: true
		},{ 
			id			: 'nm_pegawai'
		,	header		: 'Nama Pegawai'
		, 	dataIndex	: 'nm_pegawai'
		, 	filterable	: true
		},{
			header		:'Jenis Ketenagaan'
		,	dataIndex	:'nm_jenis_ketenagaan'
		,	align		:'center'
		,	width		: 150
		},
			this.checkColumn
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.grid.EditorGridPanel({
			id					: 'adm_adm_pegawai_aktifasi_panel'
		,	title				: this.title
		,	store				: this.store
		,	cm					: this.cm
		,	stripeRows			: true
		,	columnLines			: true
		,	clickToEdit			: 1
		,	plugins				: [this.checkColumn, this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nm_pegawai'
	});

	this.do_save = function()
	{
		if (this.ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var i;
		
		main_load.show();
		
		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ id_pegawai :  "+ mods[i].get('id_pegawai')
					+ ", status_aktif : '"+ mods[i].get('status_aktif') +"' ";

			data +="}";
		}
		data +="]";

		Ext.Ajax.request({
				url		: m_adm_adm_pegawai_aktifasi_d +'submit.jsp'
			,	params  : {
					rows	: data
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

		if (this.ha_level == 4) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}

		this.do_load();
	}
}

m_adm_adm_pegawai_aktifasi = new M_AdmAdmPegawaiAktifasi('Aktifasi Pegawai');

//@ sourceURL=m_adm_adm_pegawai_aktifasi.layout.js
