/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_pegawai_data_lain_kebutuhan_guru;
var m_adm_pegawai_data_lain_kebutuhan_guru_d = _g_root +'/module/adm_pegawai_data_lain_kebutuhan_guru/';

function M_AdmPegawaiDataLainKebutuhanGuru(title)
{
	this.title		= title;
	this.ha_level	= 0;

	this.records = [
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_kel_mata_pelajaran' }
		,	{ name	: 'nm_kel_mata_pelajaran' }
		,	{ name	: 'jumlah_tetap' }
		,	{ name	: 'jumlah_tak_tetap' }
		,	{ name	: 'jumlah_butuh' }
	];

	this.reader = new Ext.data.JsonReader(
			{ root:'rows'}
		,	this.records
	);

	this.store = new Ext.data.Store({
			url			: m_adm_pegawai_data_lain_kebutuhan_guru_d +'data.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});
	
	this.form_jumlah = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer({width:30})
		,{
			id			: 'nm_kel_mata_pelajaran'
		,	header		: 'Mata Pelajaran'
		,	dataIndex	: 'nm_kel_mata_pelajaran'
		,	readOnly	: true
		,	filterable	: true
		},{ 
			header		: 'Guru Tetap'
		, 	dataIndex	: 'jumlah_tetap'
		,	editor		: this.form_jumlah
		,	align		: 'center'
		,	width		: 150
		, 	filter		: {
				type	: 'numeric'
			}
		},{
			header		: 'Guru Tidak Tetap'
		,	dataIndex	: 'jumlah_tak_tetap'
		,	editor		: this.form_jumlah
		,	align		: 'center'
		,	width		: 150
		, 	filter		: {
				type	: 'numeric'
			}
		},{
			header		: 'Kebutuhan Guru'
		,	dataIndex	: 'jumlah_butuh'
		,	editor		: this.form_jumlah
		,	align		: 'center'
		,	width		: 150
		, 	filter		: {
				type	: 'numeric'
			}
		}]
	,	defaults	:{	
			sortable	: true
		,	hideable	: false
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
			id					: 'adm_pegawai_data_lain_kebutuhan_guru_panel'
		,	title				: this.title
		,	store				: this.store
		,	cm					: this.cm
		,	stripeRows			: true
		,	columnLines			: true
		,	clickToEdit			: 1
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nm_kel_mata_pelajaran'
	});

	this.do_save = function()
	{
		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var changes;
		var i,j;
		
		main_load.show();
		
		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ kd_kel_mata_pelajaran: '"+ mods[i].get('kd_kel_mata_pelajaran') +"' "
				+ ", cols: {";

			changes = mods[i].getChanges();
			j = 0;
			Ext.iterate(changes, function(k,v) {
				if (j > 0) {
					data += ",";
				} else {
					j = 1;
				}

				data += k +":"+ v;
			});

			data +="}}";
		}
		data +="]";

		Ext.Ajax.request({
				url		: m_adm_pegawai_data_lain_kebutuhan_guru_d +'submit.jsp'
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

m_adm_pegawai_data_lain_kebutuhan_guru = new M_AdmPegawaiDataLainKebutuhanGuru('Kebutuhan Guru');

//@ sourceURL=m_adm_pegawai_data_lain_kebutuhan_guru.layout.js
