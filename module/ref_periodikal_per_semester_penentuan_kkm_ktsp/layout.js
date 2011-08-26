/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_periodikal_per_semester_penentuan_kkm_ktsp;
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master;
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_detail;
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_d = _g_root +'/module/ref_periodikal_per_semester_penentuan_kkm_ktsp/';
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran = '';
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas = '';
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel = '';
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum = '';
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar = '';
var m_ref_periodikal_per_semester_penentuan_kkm_ktsp_ha_level = 0;

function m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master_on_select_load_detail()
{
 	if (typeof m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master == 'undefined'
	||  typeof m_ref_periodikal_per_semester_penentuan_kkm_ktsp_detail == 'undefined'
	||	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran == ''
	||	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas == ''
	||	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel == ''
	||	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum == ''
	||	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar == '') {
		return;
	}

	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_detail.do_refresh();
}

function M_RefPeriodikalPerSemesterPenentuanKKMKTSPMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'kd_kurikulum' }
		,	{ name	: 'kd_periode_belajar' }
		,	{ name	: 'nip' }
		,	{ name	: 'id_ruang_kelas' }
		,	{ name	: 'keterangan' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'nm_ruang_kelas' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_d +'data_master.jsp'
		,	autoLoad	: false
	});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			}
		,	{ header		: 'Rombel'
			, dataIndex		: 'kd_rombel'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			}
		,	{ header		: 'Wali Kelas'
			, dataIndex		: 'nm_pegawai'
			, sortable		: true
			, width			: 250
			}
		,	{ header		: 'Ruang Kelas'
			, dataIndex		: 'nm_ruang_kelas'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
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
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran = data[0].data['kd_tahun_ajaran'];
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas = data[0].data['kd_tingkat_kelas'];
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel = data[0].data['kd_rombel'];
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum = data[0].data['kd_kurikulum'];
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar = data[0].data['kd_periode_belajar'];
						} else {
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran = '';
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas = '';
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel = '';
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum = '';
							m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar = '';
						}

						m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master_on_select_load_detail();
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
		,	autoExpandColumn	: 'keterangan'
	});

	this.do_load = function()
	{
		this.store.load();

		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar = '';
		
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_ref_periodikal_per_semester_penentuan_kkm_ktsp_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefPeriodikalPerSemesterPenentuanKKMKTSPDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'kd_kurikulum' }
		,	{ name	: 'kd_periode_belajar' }
		,	{ name	: 'kd_mata_pelajaran_diajarkan' }
		,	{ name	: 'kkm' }
		,	{ name	: 'nm_mata_pelajaran_diajarkan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.form_kkm = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 100
		,	maxText			: 'Nilai Maksimal KKM adalah 100'
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_mata_pelajaran_diajarkan'
			, header		: 'Mata Pelajaran Diajarkan'
			, dataIndex		: 'nm_mata_pelajaran_diajarkan'
			, sortable		: true
			, editable		: false
			, filterable	: true
			}
		,	{ header		: 'KKM'
			, dataIndex		: 'kkm'
			, editor		: this.form_kkm
			, sortable		: true
			, align			: 'center'
			, width			: 100
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
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_mata_pelajaran_diajarkan'
		,	listeners	: {
					scope		: this
				,	rowclick	: function (g, r, e) {
						return this.do_edit(r);
					}
			}
	});

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
						kd_tahun_ajaran				: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran
					,	kd_tingkat_kelas			: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas
					,	kd_rombel					: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel
					,	kd_kurikulum				: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum
					,	kd_periode_belajar			: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar
					,	kd_mata_pelajaran_diajarkan	: record.data['kd_mata_pelajaran_diajarkan']
					,	kkm							: record.data['kkm']
					,	dml_type					: this.dml_type
				}
			,	url		: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_d +'submit.jsp'
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
		if (m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran == '' 
		|| m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas == ''
		|| m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel == ''
		|| m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum == ''
		|| m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Rombongan Belajar terlebih dahulu!");
			return;
		}

		if (m_ref_periodikal_per_semester_penentuan_kkm_ktsp_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
					kd_tahun_ajaran		: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas
				,	kd_rombel			: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel
				,	kd_kurikulum		: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum
				,	kd_periode_belajar	: m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_periodikal_per_semester_penentuan_kkm_ktsp_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}

}

function M_RefPeriodikalPerSemesterPenentuanKKMKTSP()
{
	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master	= new M_RefPeriodikalPerSemesterPenentuanKKMKTSPMaster('Rombongan Belajar');
	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_detail	= new M_RefPeriodikalPerSemesterPenentuanKKMKTSPDetail('Mata Pelajaran per Rombel');
	
	this.panel = new Ext.Panel({
			id			: 'ref_periodikal_per_semester_penentuan_kkm_ktsp_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master.grid
			,	m_ref_periodikal_per_semester_penentuan_kkm_ktsp_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_ha_level	= ha_level;
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tahun_ajaran = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_tingkat_kelas = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_rombel = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_kurikulum = '';
		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_kd_periode_belajar = '';

		m_ref_periodikal_per_semester_penentuan_kkm_ktsp_master.do_refresh(ha_level);
	}

}

m_ref_periodikal_per_semester_penentuan_kkm_ktsp = new M_RefPeriodikalPerSemesterPenentuanKKMKTSP();

//@ sourceURL=ref_periodikal_per_semester_penentuan_kkm_ktsp.layout.js
