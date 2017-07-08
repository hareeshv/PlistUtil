#==================================================================================================================================
#
#          FILE:  PlistUtil.pm
#
#         USAGE:
#
#   DESCRIPTION:  This module provides API's to edit and convert Plist file to JSON and vice versa.
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  Documentation/comments are not available for private methods because they are self explanatory :P
#        AUTHOR:  Hareesh.Veligeti
#       COMPANY:
#       VERSION:  1.0
#       CREATED:  06/06/2017 04:02:01 PM IST
#      REVISION:  ---
#==================================================================================================================================

package PlistUtil;
use strict;
use warnings FATAL => 'all';
use JSON;

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Private ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#/////////////////////////////////////////////////////////////////////////////
=pod

=head2 createFileFromJSON

 Parameters  : Hash refernce and file path
 Returns     : None
 Description : Writes Hash reference to a JSON file and then converts it to Plist
 				format and saves it to file path.
 				Don't worry we are deleting the temperary JSON :).

=cut

sub createFileFromJSON
{
	my ($json_ref, $fileName) = @_;
	$json_ref = encode_json($json_ref);
	open(my $fh, '>', "$fileName.json") or die "Could not open file $fileName.json $!";
	print $fh $json_ref;
	close $fh;
	$fileName =~ s/ /\\ /g;#replacing space as escape to make it look like path for shell cmd.
	my $JSONFileName = "$fileName.json";
	`plutil -convert xml1 -o - $JSONFileName > $fileName`;
	`rm $JSONFileName`;
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End of Private methods ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ API's ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#JSONFromProjectFile
sub convertProjectFileToJSON
{
	my $content;
	my $fileName = shift;
	my $temp = $fileName;
	$temp =~ s/ /\\ /g;
	my $JSONFileName = "$temp.json";
	print `plutil -convert json -o - $temp > $JSONFileName`;
	open(my $fh, '<', "$fileName.json") or die "cannot convert $fileName to json";
	{
		local $/;
		$content = <$fh>;
	}
	close($fh);
	`rm $JSONFileName`;
	return decode_json($content);
}

#/////////////////////////////////////////////////////////////////////////////

=head2 convertPLISTFileToJSON

 Parameters  : Plist file path
 Returns     : Hash(JSON Dictionary)
 Description : converts plist to JSON file and returns perl Hash.

=cut


sub convertPLISTFileToJSON
{
	convertProjectFileToJSON(shift);
}


#/////////////////////////////////////////////////////////////////////////////
=pod

=head2 createProjectFromJSON

 Parameters  : Hash refernce and file path
 Returns     : None
 Description : Refer to "createFileFromJSON".

=cut

sub createProjectFromJSON
{
	my ($json_ref, $filename) = @_;
	createFileFromJSON($json_ref, $filename);
}


#/////////////////////////////////////////////////////////////////////////////
=pod

=head2 createPLISTFromJSON

 Parameters  : Hash refernce and file path
 Returns     : None
 Description : Refer to "createFileFromJSON".

=cut

sub createPLISTFromJSON
{
	my ($json_ref, $filename) = @_;
	createFileFromJSON($json_ref, $filename);
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~End of API's ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1;
