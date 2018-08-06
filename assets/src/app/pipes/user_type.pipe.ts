import { Pipe, PipeTransform } from '@angular/core';
/*
 * Usage:
 *   value | userType
 * Example:
 *   {{ 'alumni' | userType }}
 *   formats to: "Alumni"
*/
@Pipe({name: 'userType'})
export class UserTypePipe implements PipeTransform {

  transform(userType: string): string {
    var allUserType = [
      { id: 'alumni', name: 'Alumni' },
      { id: 'professor', name: 'Professor' },
      { id: 'student', name: 'Student' },
    ];

    for (var i = allUserType.length - 1; i >= 0; i--) {
      if(allUserType[i].id == userType){
        return allUserType[i].name;
      }
    }
    return userType;
  }
}