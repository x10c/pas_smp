/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_nasional_akademik_mata_pelajaran;
var m_ref_nasional_akademik_mata_pelajaran_d = _g_root +'/module/ref_nasional_akademik_mata_pelajaran/';
var m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran;
var m_ref_nasional_akademik_mata_pelajaran_mata_pelajaran_diajarkan;
var m_ref_nasional_akademik_mata_pelajaran_kd_kel_mata_pelajaran = '';
var m_ref_nasional_akademik_mata_pelajaran_ha_level = 0;

function m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran_on_select_load_mata_pelajaran_diajarkan()
{
	if (typeof m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran == 'undefined'
	||  typeof m_ref_nasional_akademik_mata_pelajaran_mata_pelajaran_diajarkan == 'undefined'
	||  m_ref_nasional_akademik_mata_pelajaran_kd_kel_mata_pelajaran == '') {
		return;
	}

	m_ref_nasional_akademik_mata_pelajaran_mata_pelajaran_diajarkan.do_load();
}

function M_RefNasionalAkademikMataPelajaranKelMataPelajaran(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'kd_kel_mata_pelajaran'
		},{
			name	: 'nm_kel_mata_pelajaran'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_akademik_mata_pelajaran_d +'data_kel_mata_pelajaran.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kode'
			, dataIndex	: 'kd_kel_mata_pelajaran'
			, sortable	: true
			, align		: 'center'
			, width		: '100'
			}
		,	{ id		: 'nm_kel_mata_pelajaran'
			, header	: 'Nama Kelompok Mata Pelajaran'
			, dataIndex	: 'nm_kel_mata_pelajaran'
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
						m_ref_nasional_akademik_mata_pelajaran_kd_kel_mata_pelajaran = data[0].data['kd_kel_mata_pelajaran'];
					} else {
						m_ref_nasional_akademik_mata_pelajaran_kd_kel_mata_pelajaran = '';
					}

					m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran_on_select_load_mata_pelajaran_diajarkan();
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
		,	autoExpandColumn: 'nm_kel_mata_pelajaran'
		,	collapsible	: true
		,	width		: '50%'
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
		if (m_ref_nasional_akademik_mata_pelajaran_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefNasionalAkademikMataPelajaranMataPelajaranDiajarkan(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'kd_kel_mata_pelajaran'
		},{
			name	: 'kd_mata_pelajaran_diajarkan'
		},{
			name	: 'nm_mata_pelajaran_diajarkan'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_akademik_mata_pelajaran_d +'data_mata_pelajaran_diajarkan.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kode'
			, dataIndex	: 'kd_mata_pelajaran_diajarkan'
			, sortable	: true
			, align		: 'center'
			, width		: '100'
			}
		,	{ id		: 'nm_mata_pelajaran_diajarkan'
			, header	: 'Nama Mata Pelajaran Diajarkan'
			, dataIndex	: 'nm_mata_pelajaran_diajarkan'
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
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_mata_pelajaran_diajarkan'
		});

	this.do_load = function()
	{
		this.store.load({
			scope		: this
		,	params		: {
				kd_kel_mata_pelajaran : m_ref_nasional_akademik_mata_pelajaran_kd_kel_mata_pelajaran
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
		if (m_ref_nasional_akademik_mata_pelajaran_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}
	}
}

function M_RefNasionalAkademikMataPelajaran()
{
	m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran	= new M_RefNasionalAkademikMataPelajaranKelMataPelajaran('Kelompok Mata Pelajaran');
	m_ref_nasional_akademik_mata_pelajaran_mata_pelajaran_diajarkan	= new M_RefNasionalAkademikMataPelajaranMataPelajaranDiajarkan('Mata Pelajaran Diajarkan');

	this.panel = new Ext.Panel({
			id			: 'ref_nasional_akademik_mata_pelajaran_panel'
		,	layout		: 'border'
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items		: [
				m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran.grid
			,	m_ref_nasional_akademik_mata_pelajaran_mata_pelajaran_diajarkan.grid
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_nasional_akademik_mata_pelajaran_ha_level			= ha_level;
		m_ref_nasional_akademik_mata_pelajaran_kd_kel_mata_pelajaran 	= '';

		m_ref_nasional_akademik_mata_pelajaran_kel_mata_pelajaran.do_refresh();
		m_ref_nasional_akademik_mata_pelajaran_mata_pelajaran_diajarkan.do_refresh();
	}
}

var m_ref_nasional_akademik_mata_pelajaran = new M_RefNasionalAkademikMataPelajaran();

//@ sourceURL=ref_nasional_akademik_mata_pelajaran.layout.js
