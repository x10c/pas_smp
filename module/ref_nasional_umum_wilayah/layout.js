/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_nasional_umum_wilayah;
var m_ref_nasional_umum_wilayah_d = _g_root +'/module/ref_nasional_umum_wilayah/';
var m_ref_nasional_umum_wilayah_propinsi;
var m_ref_nasional_umum_wilayah_kabupaten;
var m_ref_nasional_umum_wilayah_kecamatan;
var m_ref_nasional_umum_wilayah_id_propinsi	= '';
var m_ref_nasional_umum_wilayah_id_kabupaten = '';
var m_ref_nasional_umum_wilayah_ha_level = 0;

function m_ref_nasional_umum_wilayah_propinsi_on_select_load_kabupaten()
{
	if (typeof m_ref_nasional_umum_wilayah_propinsi == 'undefined'
	||  typeof m_ref_nasional_umum_wilayah_kabupaten == 'undefined'
	||  m_ref_nasional_umum_wilayah_id_propinsi == '') {
		return;
	}

	m_ref_nasional_umum_wilayah_kabupaten.do_load();
	m_ref_nasional_umum_wilayah_kecamatan.store.removeAll();
}

function m_ref_nasional_umum_wilayah_kabupaten_on_select_load_kecamatan()
{
	if (typeof m_ref_nasional_umum_wilayah_propinsi == 'undefined'
	||  typeof m_ref_nasional_umum_wilayah_kabupaten == 'undefined'
	||  typeof m_ref_nasional_umum_wilayah_kecamatan == 'undefined'
	||  m_ref_nasional_umum_wilayah_id_propinsi == ''
	||  m_ref_nasional_umum_wilayah_id_kabupaten == '') {
		return;
	}

	m_ref_nasional_umum_wilayah_kecamatan.do_load();
}

function M_RefNasionalUmumWilayahPropinsi(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_propinsi'
		},{
			name	: 'nm_propinsi'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_umum_wilayah_d +'data_propinsi.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nm_propinsi'
			, header	: 'Nama Propinsi'
			, dataIndex	: 'nm_propinsi'
			, sortable	: true
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_ref_nasional_umum_wilayah_id_propinsi = data[0].data['id_propinsi'];
					} else {
						m_ref_nasional_umum_wilayah_id_propinsi = '';
					}

					m_ref_nasional_umum_wilayah_propinsi_on_select_load_kabupaten();
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
			title		: this.title
		,	region		: 'west'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_propinsi'
		,	collapsible	: true
		,	width		: '33%'
	});

	this.do_load = function()
	{
		this.store.load({
			scope	:this
		,	callback: function(r,options,success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_nasional_umum_wilayah_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefNasionalUmumWilayahKabupaten(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_propinsi'
		},{
			name	: 'id_kabupaten'
		},{
			name	: 'nm_kabupaten'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_umum_wilayah_d +'data_kabupaten.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nm_kabupaten'
			, header	: 'Nama Kabupaten/Kota'
			, dataIndex	: 'nm_kabupaten'
			, sortable	: true
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_ref_nasional_umum_wilayah_id_kabupaten = data[0].data['id_kabupaten'];
					} else {
						m_ref_nasional_umum_wilayah_id_kabupaten = '';
					}

					m_ref_nasional_umum_wilayah_kabupaten_on_select_load_kecamatan();
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
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_kabupaten'
		});

	this.do_load = function()
	{
		this.store.load({
			scope		: this
		,	params		: {
				id_propinsi : m_ref_nasional_umum_wilayah_id_propinsi
			}
		,	callback: function(r, options, success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_nasional_umum_wilayah_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}
	}
}

function M_RefNasionalUmumWilayahKecamatan(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_propinsi'
		},{
			name	: 'id_kabupaten'
		},{
			name	: 'id_kecamatan'
		},{
			name	: 'nm_kecamatan'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_umum_wilayah_d +'data_kecamatan.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nm_kecamatan'
			, header	: 'Nama Kecamatan'
			, dataIndex	: 'nm_kecamatan'
			, sortable	: true
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
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
			title		: this.title
		,	region		: 'east'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_kecamatan'
		,	collapsible	: true
		,	width		: '33%'
		});

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_propinsi		: m_ref_nasional_umum_wilayah_id_propinsi
			,	id_kabupaten	: m_ref_nasional_umum_wilayah_id_kabupaten
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_nasional_umum_wilayah_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}
	}
}

function M_RefNasionalUmumWilayah()
{
	m_ref_nasional_umum_wilayah_propinsi	= new M_RefNasionalUmumWilayahPropinsi('Propinsi');
	m_ref_nasional_umum_wilayah_kabupaten	= new M_RefNasionalUmumWilayahKabupaten('Kabupaten/Kota');
	m_ref_nasional_umum_wilayah_kecamatan	= new M_RefNasionalUmumWilayahKecamatan('Kecamatan');

	this.panel = new Ext.Panel({
			id			: 'ref_nasional_umum_wilayah_panel'
		,	layout		: 'border'
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items		: [
				m_ref_nasional_umum_wilayah_propinsi.grid
			,	m_ref_nasional_umum_wilayah_kabupaten.grid
			,	m_ref_nasional_umum_wilayah_kecamatan.grid
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_nasional_umum_wilayah_ha_level		= ha_level;
		m_ref_nasional_umum_wilayah_id_propinsi 	= '';
		m_ref_nasional_umum_wilayah_id_kabupaten	= '';

		m_ref_nasional_umum_wilayah_propinsi.do_refresh();
		m_ref_nasional_umum_wilayah_kabupaten.do_refresh();
		m_ref_nasional_umum_wilayah_kecamatan.do_refresh();
	}
}

var m_ref_nasional_umum_wilayah = new M_RefNasionalUmumWilayah();

//@ sourceURL=ref_nasional_umum_wilayah.layout.js
