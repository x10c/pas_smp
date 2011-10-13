/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_app_export_data;
var m_app_export_data_kd_tahun_ajaran;
var m_app_export_data_npsn;
var m_app_export_data_id_propinsi;
var m_app_export_data_id_kabupaten;
var m_app_export_data_id_kecamatan;
var m_app_export_data_d = _g_root +'/module/app_export_data/';

function M_AppExportData(title)
{
	this.title		= title;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'nm_tahun_ajaran' }
		,	{ name	: 'npsn' }
		,	{ name	: 'id_propinsi' }
		,	{ name	: 'id_kabupaten' }
		,	{ name	: 'id_kecamatan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_app_export_data_d +'data.jsp'
		,	autoLoad	: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tahun Pelajaran'
			, dataIndex		: 'nm_tahun_ajaran'
			, sortable		: true
			, editable		: false
			, align			: 'center'
			, width			: 200
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_app_export_data_kd_tahun_ajaran	= data[0].data['kd_tahun_ajaran'];
							m_app_export_data_npsn 				= data[0].data['npsn'];
							m_app_export_data_id_propinsi		= data[0].data['id_propinsi'];
							m_app_export_data_id_kabupaten		= data[0].data['id_kabupaten'];
							m_app_export_data_id_kecamatan		= data[0].data['id_kecamatan'];
							this.btn_export.setDisabled(false);
						} else {
							m_app_export_data_kd_tahun_ajaran 	= '';
							m_app_export_data_npsn 				= '';
							m_app_export_data_id_propinsi		= '';
							m_app_export_data_id_kabupaten		= '';
							m_app_export_data_id_kecamatan		= '';
							this.btn_export.setDisabled(true);
						}
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

	this.btn_export = new Ext.Button({
			text		: 'Export'
		,	iconCls		: 'export16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_export();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_export
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'app_export_data_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	tbar				: this.tbar
	});

	this.f = function(v){
		return function(){
			var i = v/28;
			Ext.MessageBox.updateProgress(i, Math.round(100*i) + '% selesai');

			if(v == 28){
				Ext.MessageBox.hide();
				Ext.MessageBox.alert('Informasi', 'Export Data berhasil dilakukan!');
			} else {
				Ext.Ajax.request({
						url		: m_app_export_data_d + 'data_' + v + '.jsp'
					,	params  :
						{
							npsn			: m_app_export_data_npsn
						,	id_propinsi		: m_app_export_data_id_propinsi
						,	id_kabupaten	: m_app_export_data_id_kabupaten
						,	id_kecamatan	: m_app_export_data_id_kecamatan
						}
					,	scope	: this
				});					
			}
		}
	};

	this.do_export = function()
	{
		Ext.MessageBox.show({
			title			: 'Mohon Tunggu...'
		,	msg				: 'Export Data...'
		,	progressText	: 'Inisialisasi...'
		,	width			: 300
		,	progress		: true
		,	closable		: false
		});

			
		for(var i = 1; i <= 28; i++){
			setTimeout(this.f(i), i*500);
		}
	}
	
	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_app_export_data = new M_AppExportData('Export Data');

//@ sourceURL=app_export_data.layout.js
