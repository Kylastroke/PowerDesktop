#region function fillDetailedListView
function fillDetailedListView
{
    <#
        .Synopsis
            Depending Of Specs . Columns Will Be Created IF Need Be 
        .Description
            This function creates Rows Based From Supplied String Arrays . Optionally Clearing Or Re-Populating Said Columns From Submitted Data 
        .Parameter ListView
            A reference to a listview control
        .Parameter CleanUp
            An optional flag to clear columns and data before appending new data to the ViewController
        .Parameter ColumnName
            A string array which will be used as a list of header names
        .Parameter Data
            A string array which will used as a list of data to be added to a new row
        .Parameter Color
            A flag of the [System.Drawing.SystemColors]::Window type to apply to the newly created row
        .Example
            fillListView ([ref]$lv) $false (,'Name') (,$key) $null; 
        .Notes
            Author:  @Kylastroke 
    #>
    param(
        [ref]$ListView,
        [bool]$CleanUp = $false,
        [string[]]$ColumnName,
        [string[]]$Data,
         $Color,
        [int]$ImageIndex = $null,
        [string]$NodeKey = ''
    )
    if ($cleanUp) #if clean-up is required
    {
        ($ListView.Value).Columns.Clear();
    }
    for ($i = 0; $i -lt $ColumnName.Length; $i++)
    {#check whether the Current column exists or not
        if ( -not ([System.Windows.Forms.ListView] `
            ($ListView.Value)).Columns[$ColumnName[$i]])
        {#add only if it's a new one
            ($ListView.Value).Columns.AddRange(
                (($header = New-Object System.Windows.Forms.ColumnHeader) `
                    | %{$header.Text = $ColumnName[$i]; 
                        $header.Name = $ColumnName[$i]; 
                        $header;}));
        }
    }
    if ($Color -eq $null -or `
        $Color.GetType().ToString() -ne 'System.Drawing.SystemColors')
    {#input test of the $Color variable
        $Color = [System.Drawing.SystemColors]::Window;
    }
    #adding items aka rows (an item is a single element of a row,
    #a place where a row and a column are intercrossed
    $listViewItem1 = (($listViewItem = New-Object "System.Windows.Forms.ListViewItem") `
        | %{$listViewItem.Text = $Data[0]; 
            if ($Color -ne [System.Drawing.SystemColors]::Window)
            {#set $Color to all items in the row
                $listViewItem.BackColor = $Color;
                $listViewItem.UseItemStyleForSubItems = $true;
            }
                       if ($ImageIndex -ne $null)
            {#if you have an ImageList control in your form
                $listViewItem.ImageIndex = $ImageIndex + 1;
            }
            if ($NodeKey -ne $null -and $NodeKey.Length -gt 0)
            {
                $listViewItem.Tag = $NodeKey;
            }
        #more columns
        for ($i = 1; $i -lt $Data.Length; $i++)
        {#adding data to the row items
            $listViewItem.SubItems.Add((([System.Windows.Forms.ListViewItem`+ListViewSubItem]$subItem = `
                New-Object System.Windows.Forms.ListViewItem`+ListViewSubItem) `
                | %{$subItem.Text = $Data[$i]; 
                    $subItem;}));
        }
        $listViewItem;}
        )
    ($ListView.Value).Items.Add($listViewItem);
    #setting AutoREsize property
    if ($Data -ne $null -and $Data.Length -gt 1)
    {
        ($ListView.Value).AutoResizeColumns([System.Windows.Forms.ColumnHeaderAutoResizeStyle]::ColumnContent);
    }
    else
    {
        ($ListView.Value).AutoResizeColumns([System.Windows.Forms.ColumnHeaderAutoResizeStyle]::HeaderSize);
    }
}
#endregion function fillDetailedListView






